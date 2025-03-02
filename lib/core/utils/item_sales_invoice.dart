import 'dart:io';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/item_sales_response_model.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:excel/excel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';

class ItemSalesInvoice {
  static late Font ttf;

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

  static Future<String> _getOutletAddress(int outletId) async {
    try {
      final outletDataSource = OutletLocalDataSource();
      final allOutlets = await outletDataSource.getAllOutlets();
      print('Available outlets: ${allOutlets.length}');
      for (var outlet in allOutlets) {
        print('Outlet ${outlet.id}: ${outlet.name}, ${outlet.address}');
      }

      final outlet = await outletDataSource.getOutletById(outletId);

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
      List<ItemSales> itemSales, String searchDateFormatted,
      {int? outletId}) async {
    final pdf = Document();
    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();
    final image = pw.MemoryImage(bytes);

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    print('Using outletId: $outletId for PDF generation');

    final String outletAddress = await _getOutletAddress(outletId);
    print('Using address: $outletAddress for PDF');

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(image, searchDateFormatted),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoice(itemSales),
          Divider(),
          SizedBox(height: 0.25 * PdfPageFormat.cm),
        ],
        footer: (context) => buildFooter(outletAddress),
      ),
    );

    return HelperPdfService.saveDocument(
      name:
          'Seblak Sulthane | Item Sales Report | ${DateTime.now().millisecondsSinceEpoch}.pdf',
      pdf: pdf,
    );
  }

  static Widget buildHeader(MemoryImage image, String searchDateFormatted) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Text('Seblak Sulthane | Item Sales Report',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Text("Data: $searchDateFormatted"),
            Text('Created At: ${DateTime.now().toFormattedDate3()}'),
          ],
        ),
        Image(
          image,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.fill,
        ),
      ]);

  static Widget buildInvoice(List<ItemSales> itemSales) {
    final headers = ['Id', 'Order', 'Product', 'Qty', 'Price', 'Total'];
    final data = itemSales.map((item) {
      return [
        item.id!,
        item.orderId,
        item.productName,
        item.quantity,
        (item.price! * 100).currencyFormatRp,
        (item.price! * item.quantity! * 100).currencyFormatRp
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
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
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

  static Future<File> generateExcel(
      List<ItemSales> itemSales, String searchDateFormatted,
      {int? outletId}) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Item Sales Report'];

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    print('Using outletId: $outletId for Excel generation');

    final String outletAddress = await _getOutletAddress(outletId);
    print('Using address: $outletAddress for Excel');

    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("F1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value = TextCellValue('Seblak Sulthane | Item Sales Report');
    headerCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("F2"));
    final dateCell = sheet.cell(CellIndex.indexByString("A2"));
    dateCell.value = TextCellValue('Data: $searchDateFormatted');
    dateCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("F3"));
    final createdCell = sheet.cell(CellIndex.indexByString("A3"));
    createdCell.value =
        TextCellValue('Created At: ${DateTime.now().toFormattedDate3()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A4"), CellIndex.indexByString("F4"));

    final headers = ['Id', 'Order', 'Product', 'Qty', 'Price', 'Total'];
    for (var i = 0; i < headers.length; i++) {
      final headerCell =
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 5));
      headerCell.value = TextCellValue(headers[i]);
      headerCell.cellStyle = CellStyle(
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
      );
    }

    for (var i = 0; i < itemSales.length; i++) {
      final item = itemSales[i];
      final rowIndex = i + 6;

      final idCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex));
      idCell.value = item.id != null
          ? TextCellValue(item.id.toString())
          : TextCellValue('');
      idCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      final orderCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex));
      orderCell.value = TextCellValue(item.orderId.toString());
      orderCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      final productCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex));
      productCell.value = TextCellValue(item.productName ?? '');
      productCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Center);

      final qtyCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex));
      qtyCell.value = item.quantity != null
          ? TextCellValue(item.quantity.toString())
          : TextCellValue('');
      qtyCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      final priceCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex));
      priceCell.value = TextCellValue(item.price?.currencyFormatRp ?? '');
      priceCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      final totalCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex));
      totalCell.value = TextCellValue(
          (item.price != null && item.quantity != null)
              ? (item.price! * item.quantity!).currencyFormatRp
              : '');
      totalCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);
    }

    final footerRowIndex = itemSales.length + 8;
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex),
      CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: footerRowIndex),
    );
    final footerCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex));
    footerCell.value = TextCellValue('Address: $outletAddress');

    sheet.setColumnWidth(0, 15.0);
    sheet.setColumnWidth(1, 15.0);
    sheet.setColumnWidth(2, 40.0);
    sheet.setColumnWidth(3, 15.0);
    sheet.setColumnWidth(4, 25.0);
    sheet.setColumnWidth(5, 25.0);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return HelperExcelService.saveExcel(
      name: 'seblak_sulthane_sales_report_$timestamp.xlsx',
      excel: excel,
    );
  }
}
