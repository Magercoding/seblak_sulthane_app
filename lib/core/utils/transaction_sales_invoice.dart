import 'dart:io';

import 'package:excel/excel.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:seblak_sulthane_app/data/models/response/order_response_model.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';

class TransactionSalesInvoice {
  static late Font ttf;

  // Get outletId from user profile, similar to ReportPage
  static Future<int?> _fetchOutletIdFromProfile() async {
    try {
      final authRemoteDatasource = AuthRemoteDatasource();
      final result = await authRemoteDatasource.getProfile();

      int? outletId;
      result.fold(
        (error) {
          print('Error fetching profile: $error');
          return null;
        },
        (user) {
          outletId = user.outletId;
        },
      );

      return outletId;
    } catch (e) {
      print('Exception fetching profile: $e');
      return null;
    }
  }

  // Get outlet address using outletId
  static Future<String> _getOutletAddress(int outletId) async {
    try {
      // Debug: check all available outlets
      final outletDataSource = OutletLocalDataSource();
      final allOutlets = await outletDataSource.getAllOutlets();
      print('Available outlets: ${allOutlets.length}');
      for (var outlet in allOutlets) {
        print('Outlet ${outlet.id}: ${outlet.name}, ${outlet.address}');
      }

      final outlet = await outletDataSource.getOutletById(outletId);

      // If the specific outlet is not found but we have other outlets, use the first one
      if (outlet == null && allOutlets.isNotEmpty) {
        print(
            'Outlet with ID $outletId not found, using first available outlet instead');
        return allOutlets.first.address ?? 'Seblak Sulthane';
      }

      return outlet?.address ?? 'Seblak Sulthane';
    } catch (e) {
      print('Error getting outlet address: $e');
      return 'Seblak Sulthane';
    }
  }

  static Future<File> generatePdf(
      List<ItemOrder> itemOrders, String searchDateFormatted,
      {int? outletId}) async {
    final pdf = Document();
    // var data = await rootBundle.load("assets/fonts/noto-sans.ttf");
    // ttf = Font.ttf(data);
    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();

    // Membuat objek Image dari gambar
    final image = pw.MemoryImage(bytes);

    // If outletId is not provided, try to fetch it from profile
    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1; // Default to 1 if still null

    print('Using outletId: $outletId for PDF generation');

    // Get outlet address
    final String outletAddress = await _getOutletAddress(outletId);
    print('Using address: $outletAddress for PDF');

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(image, searchDateFormatted),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoice(itemOrders),
          Divider(),
          SizedBox(height: 0.25 * PdfPageFormat.cm),
        ],
        footer: (context) => buildFooter(outletAddress),
      ),
    );

    return HelperPdfService.saveDocument(
        name:
            'Seblak Sulthane | Transaction Sales Report | ${DateTime.now().millisecondsSinceEpoch}.pdf',
        pdf: pdf);
  }

  static Widget buildHeader(MemoryImage image, String searchDateFormatted) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Text('Seblak Sulthane | Transaction Sales Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Text(
              "Data: $searchDateFormatted",
            ),
            Text(
              'Created At: ${DateTime.now().toFormattedDate3()}',
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

  static Widget buildInvoice(List<ItemOrder> itemOrders) {
    final headers = [
      'ID',
      'Total',
      'Sub Total',
      'Tax',
      'Discount',
      'Service',
      'Total Item',
      'Kasir',
      'Time'
    ];
    final data = itemOrders.map((item) {
      return [
        item.id.toString(),
        item.total!.currencyFormatRp,
        item.subTotal!.currencyFormatRp,
        item.tax!.currencyFormatRp,
        int.parse(item.discountAmount!.replaceAll('.00', '')).currencyFormatRp,
        item.serviceCharge!.currencyFormatRp,
        item.totalItem.toString(),
        item.namaKasir ?? '',
        item.transactionTime!.toFormattedDate(),
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(
          fontWeight: FontWeight.bold, color: PdfColor.fromHex('FFFFFF')),
      headerDecoration: BoxDecoration(color: PdfColors.blue),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.center, // ID
        1: Alignment.centerRight, // Total
        2: Alignment.centerRight, // Sub Total
        3: Alignment.centerRight, // Tax
        4: Alignment.centerRight, // Discount
        5: Alignment.centerRight, // Service
        6: Alignment.center, // Total Item
        7: Alignment.center, // Kasir
        8: Alignment.center, // Time
      },
    );
  }

  static Widget buildFooter(String outletAddress) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: outletAddress),
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

  // Excel Generation
  static Future<File> generateExcel(
      List<ItemOrder> itemOrders, String searchDateFormatted,
      {int? outletId}) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Transaction Sales Report'];

    // If outletId is not provided, try to fetch it from profile
    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1; // Default to 1 if still null

    print('Using outletId: $outletId for Excel generation');

    // Get outlet address
    final String outletAddress = await _getOutletAddress(outletId);
    print('Using address: $outletAddress for Excel');

    // Add Header with company info
    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("I1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value =
        TextCellValue('Seblak Sulthane | Transaction Sales Report');
    headerCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
    );

    // Add date information
    sheet.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("I2"));
    final dateCell = sheet.cell(CellIndex.indexByString("A2"));
    dateCell.value = TextCellValue('Data: $searchDateFormatted');
    dateCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("I3"));
    final createdCell = sheet.cell(CellIndex.indexByString("A3"));
    createdCell.value =
        TextCellValue('Created At: ${DateTime.now().toFormattedDate3()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    // Add empty row for spacing
    sheet.merge(CellIndex.indexByString("A4"), CellIndex.indexByString("I4"));

    // Add table headers
    final headers = [
      'ID',
      'Total',
      'Sub Total',
      'Tax',
      'Discount',
      'Service',
      'Total Item',
      'Kasir',
      'Time'
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

    // Add data rows
    for (var i = 0; i < itemOrders.length; i++) {
      final item = itemOrders[i];
      final rowIndex = i + 6;

      // ID
      final idCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex));
      idCell.value = TextCellValue(item.id.toString());
      idCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      // Total
      final totalCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
      totalCell.value = TextCellValue(item.total!.currencyFormatRp);
      totalCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      // Sub Total
      final subtotalCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex));
      subtotalCell.value = TextCellValue(item.subTotal!.currencyFormatRp);
      subtotalCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Right);

      // Tax
      final taxCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex));
      taxCell.value = TextCellValue(item.tax!.currencyFormatRp);
      taxCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      // Discount
      final discountCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex));
      discountCell.value = TextCellValue(
          int.parse(item.discountAmount!.replaceAll('.00', ''))
              .currencyFormatRp);
      discountCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Right);

      // Service Charge
      final serviceCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex));
      serviceCell.value = TextCellValue(item.serviceCharge!.currencyFormatRp);
      serviceCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      // Total Item
      final totalItemCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex));
      totalItemCell.value = TextCellValue(item.totalItem.toString());
      totalItemCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Center);

      // Kasir
      final kasirCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: rowIndex));
      kasirCell.value = TextCellValue(item.namaKasir ?? '');
      kasirCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      // Time
      final timeCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: rowIndex));
      timeCell.value = TextCellValue(item.transactionTime!.toFormattedDate());
      timeCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);
    }

    // Add footer
    final footerRowIndex = itemOrders.length + 7;
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex),
      CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: footerRowIndex),
    );
    final footerCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex));
    footerCell.value = TextCellValue('Address: $outletAddress');

    // Set column widths
    sheet.setColumnWidth(0, 15.0); // ID
    sheet.setColumnWidth(1, 20.0); // Total
    sheet.setColumnWidth(2, 20.0); // Sub Total
    sheet.setColumnWidth(3, 20.0); // Tax
    sheet.setColumnWidth(4, 20.0); // Discount
    sheet.setColumnWidth(5, 20.0); // Service
    sheet.setColumnWidth(6, 15.0); // Total Item
    sheet.setColumnWidth(7, 20.0); // Kasir
    sheet.setColumnWidth(8, 30.0); // Time

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_transaction_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
