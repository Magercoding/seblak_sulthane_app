import 'dart:io';

import 'package:excel/excel.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/timezone_helper.dart';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:seblak_sulthane_app/data/models/response/order_response_model.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TransactionSalesInvoice {
  static late Font ttf;

  static Future<int?> _fetchOutletIdFromProfile() async {
    try {
      final authRemoteDatasource = AuthRemoteDatasource();
      final result = await authRemoteDatasource.getProfile();

      int? outletId;
      result.fold(
        (error) {
          return null;
        },
        (user) {
          outletId = user.outletId;
        },
      );

      return outletId;
    } catch (e) {
      return null;
    }
  }

  static Future<String> _getOutletAddress(int outletId) async {
    try {
      final outletDataSource = OutletLocalDataSource();
      final outlet = await outletDataSource.getOutletById(outletId);

      if (outlet != null) {
        String address = '';

        if (outlet.address1 != null && outlet.address1!.isNotEmpty) {
          address = outlet.address1!;
        }

        if (outlet.address2 != null && outlet.address2!.isNotEmpty) {
          if (address.isNotEmpty) {
            address += ', ';
          }
          address += outlet.address2!;
        }

        return address.isNotEmpty ? address : 'Seblak Sulthane';
      }

      final allOutlets = await outletDataSource.getAllOutlets();
      if (allOutlets.isNotEmpty) {
        String address = '';
        final firstOutlet = allOutlets.first;

        if (firstOutlet.address1 != null && firstOutlet.address1!.isNotEmpty) {
          address = firstOutlet.address1!;
        }

        if (firstOutlet.address2 != null && firstOutlet.address2!.isNotEmpty) {
          if (address.isNotEmpty) {
            address += ', ';
          }
          address += firstOutlet.address2!;
        }

        return address.isNotEmpty ? address : 'Seblak Sulthane';
      }

      return 'Seblak Sulthane';
    } catch (e) {
      return 'Seblak Sulthane';
    }
  }

  static Future<File> generatePdf(
      List<ItemOrder> itemOrders, String searchDateFormatted,
      {int? outletId}) async {
    final pdf = Document();

    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();
    final image = pw.MemoryImage(bytes);

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    // Create smaller chunks to avoid memory issues
    const int itemsPerPage = 15; // Reduced from 20 to 10 items
    final int totalPages = (itemOrders.length / itemsPerPage).ceil();

    // Use a more efficient approach for page creation
    for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final int startIndex = pageIndex * itemsPerPage;
      final int endIndex = (startIndex + itemsPerPage < itemOrders.length)
          ? startIndex + itemsPerPage
          : itemOrders.length;

      final List<ItemOrder> pageItems =
          itemOrders.sublist(startIndex, endIndex);

      // Create a single page instead of MultiPage to reduce memory consumption
      pdf.addPage(
        Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildHeader(image, searchDateFormatted),
                SizedBox(height: 0.5 * PdfPageFormat.cm),
                buildInvoiceOptimized(pageItems),
                Divider(),
                SizedBox(height: 0.25 * PdfPageFormat.cm),
                Center(
                  child: Text(
                    'Halaman ${pageIndex + 1} dari $totalPages',
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Spacer(),
                buildFooter(outletAddress),
              ],
            );
          },
        ),
      );

      // Add a small delay between page generation to prevent memory pressure
      await Future.delayed(Duration(milliseconds: 20));
    }

    return HelperPdfService.saveDocument(
        name:
            'Seblak Sulthane | Laporan Penjualan Transaksi | ${DateTime.now().millisecondsSinceEpoch}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(MemoryImage image, String searchDateFormatted) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Text('Seblak Sulthane | Laporan Penjualan Transaksi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Text(
              "Data: $searchDateFormatted",
            ),
            Text(
              'Dibuat Pada: ${TimezoneHelper.nowWIB().toFormattedDate3WIB()}',
            ),
          ],
        ),
        Image(
          image,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.fill,
        ),
      ]);

  static Widget buildInvoiceOptimized(List<ItemOrder> itemOrders) {
    final headers = [
      'ID',
      'Total',
      'Sub Total',
      'Pajak',
      'Diskon',
      'Layanan',
      'Total Item',
      'Metode',
      'Kasir',
      'Waktu'
    ];

    // Simplify the data structure to reduce memory usage
    final data = itemOrders.map((item) {
      return [
        item.id.toString(),
        item.total!.currencyFormatRp,
        item.subTotal!.currencyFormatRp,
        item.tax!.currencyFormatRp,
        int.parse(item.discountAmount!.replaceAll('.00', '')).currencyFormatRp,
        item.serviceCharge!.currencyFormatRp,
        item.totalItem.toString(),
        item.paymentMethod ?? 'Tunai',
        item.namaKasir ?? '',
        item.transactionTime!.toFormattedDateWIB(),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: PdfColor.fromHex('FFFFFF'),
        fontSize: 9, // Reduced font size
      ),
      cellStyle: TextStyle(fontSize: 8), // Reduced cell font size
      headerDecoration: BoxDecoration(color: PdfColors.blue),
      cellHeight: 25, // Reduced cell height
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
        6: Alignment.center,
        7: Alignment.center,
        8: Alignment.center,
        9: Alignment.center,
      },
      columnWidths: {
        0: FixedColumnWidth(30),
        1: FixedColumnWidth(50),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(40),
        4: FixedColumnWidth(40),
        5: FixedColumnWidth(40),
        6: FixedColumnWidth(30),
        7: FixedColumnWidth(40),
        8: FixedColumnWidth(40),
        9: FixedColumnWidth(60),
      },
    );
  }

  static Widget buildFooter(String outletAddress) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Alamat', value: outletAddress),
          SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static Future<File> generateExcel(
      List<ItemOrder> itemOrders, String searchDateFormatted,
      {int? outletId}) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Laporan Penjualan Transaksi'];

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("J1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value =
        TextCellValue('Seblak Sulthane | Laporan Penjualan Transaksi');
    headerCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("J2"));
    final dateCell = sheet.cell(CellIndex.indexByString("A2"));
    dateCell.value = TextCellValue('Data: $searchDateFormatted');
    dateCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("J3"));
    final createdCell = sheet.cell(CellIndex.indexByString("A3"));
    createdCell.value =
        TextCellValue('Dibuat Pada: ${TimezoneHelper.nowWIB().toFormattedDate3WIB()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A4"), CellIndex.indexByString("J4"));

    final headers = [
      'ID',
      'Total',
      'Sub Total',
      'Pajak',
      'Diskon',
      'Layanan',
      'Total Item',
      'Metode Pembayaran',
      'Kasir',
      'Waktu'
    ];
    for (var i = 0; i < headers.length; i++) {
      final headerCell =
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 5));
      headerCell.value = TextCellValue(headers[i]);
      headerCell.cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
      );
    }

    for (var i = 0; i < itemOrders.length; i++) {
      final item = itemOrders[i];
      final rowIndex = i + 6;

      final idCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex));
      idCell.value = TextCellValue(item.id.toString());
      idCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      final totalCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
      totalCell.value = TextCellValue(item.total!.currencyFormatRp);
      totalCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      final subtotalCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex));
      subtotalCell.value = TextCellValue(item.subTotal!.currencyFormatRp);
      subtotalCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Right);

      final taxCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex));
      taxCell.value = TextCellValue(item.tax!.currencyFormatRp);
      taxCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      final discountCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex));
      discountCell.value = TextCellValue(
          int.parse(item.discountAmount!.replaceAll('.00', ''))
              .currencyFormatRp);
      discountCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Right);

      final serviceCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex));
      serviceCell.value = TextCellValue(item.serviceCharge!.currencyFormatRp);
      serviceCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      final totalItemCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex));
      totalItemCell.value = TextCellValue(item.totalItem.toString());
      totalItemCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Center);

      final paymentMethodCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: rowIndex));
      paymentMethodCell.value = TextCellValue(item.paymentMethod ?? 'Tunai');
      paymentMethodCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Center);

      final kasirCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: rowIndex));
      kasirCell.value = TextCellValue(item.namaKasir ?? '');
      kasirCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      final timeCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: rowIndex));
      timeCell.value = TextCellValue(item.transactionTime!.toFormattedDate());
      timeCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);
    }

    final footerRowIndex = itemOrders.length + 7;
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex),
      CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: footerRowIndex),
    );
    final footerCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex));
    footerCell.value = TextCellValue('Alamat: $outletAddress');

    sheet.setColumnWidth(0, 15.0);
    sheet.setColumnWidth(1, 20.0);
    sheet.setColumnWidth(2, 20.0);
    sheet.setColumnWidth(3, 20.0);
    sheet.setColumnWidth(4, 20.0);
    sheet.setColumnWidth(5, 20.0);
    sheet.setColumnWidth(6, 15.0);
    sheet.setColumnWidth(7, 20.0);
    sheet.setColumnWidth(8, 20.0);
    sheet.setColumnWidth(9, 30.0);

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_laporan_transaksi_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
