import 'dart:io';
import 'package:flutter/services.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/product_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/item_sales_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';
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
      final allOutlets = await outletDataSource.getAllOutlets();
      final outlet = await outletDataSource.getOutletById(outletId);

      if (outlet == null && allOutlets.isNotEmpty) {
        return allOutlets.first.address ?? 'Seblak Sulthane';
      }

      return outlet?.address ?? 'Seblak Sulthane';
    } catch (e) {
      return 'Seblak Sulthane';
    }
  }

  // New method to fetch product categories
  static Future<Map<int, String>> _fetchProductCategories() async {
    try {
      final productRemoteDataSource = ProductRemoteDatasource();
      final productsResult = await productRemoteDataSource.getProducts();

      Map<int, String> productCategories = {};

      productsResult.fold(
        (error) {
          return productCategories; // Return empty map on error
        },
        (productResponse) {
          if (productResponse.data != null) {
            for (var product in productResponse.data!) {
              if (product.id != null && product.category?.name != null) {
                productCategories[product.id!] = product.category!.name!;
              }
            }
          }
        },
      );

      return productCategories;
    } catch (e) {
      return {}; // Return empty map on exception
    }
  }

  // Method to add categories to item sales
  static Future<List<ItemSales>> _addCategoriesToItemSales(
      List<ItemSales> itemSales) async {
    // Fetch product categories
    final productCategories = await _fetchProductCategories();

    // Create a copy of the item sales list with categories
    return itemSales.map((item) {
      // Add category if product ID matches
      if (item.productId != null &&
          productCategories.containsKey(item.productId)) {
        item.categoryName = productCategories[item.productId];
      } else {
        item.categoryName = 'Uncategorized';
      }
      return item;
    }).toList();
  }

  static Future<File> generatePdf(
      List<ItemSales> itemSales, String searchDateFormatted,
      {int? outletId}) async {
    // Add categories to item sales
    final itemSalesWithCategories = await _addCategoriesToItemSales(itemSales);

    final pdf = Document();
    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();
    final image = pw.MemoryImage(bytes);

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(image, searchDateFormatted),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildInvoice(itemSalesWithCategories),
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
    // Add Category to headers
    final headers = [
      'Id',
      'Order',
      'Product',
      'Category',
      'Qty',
      'Price',
      'Total'
    ];
    final data = itemSales.map((item) {
      return [
        item.id!,
        item.orderId,
        item.productName,
        item.categoryName ??
            'Uncategorized', // Use the category from the product
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
        3: Alignment.center, // Align category
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
        6: Alignment.centerLeft,
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
    // Add categories to item sales
    final itemSalesWithCategories = await _addCategoriesToItemSales(itemSales);

    final excel = Excel.createExcel();
    final Sheet sheet = excel['Item Sales Report'];

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("G1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value = TextCellValue('Seblak Sulthane | Item Sales Report');
    headerCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("G2"));
    final dateCell = sheet.cell(CellIndex.indexByString("A2"));
    dateCell.value = TextCellValue('Data: $searchDateFormatted');
    dateCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("G3"));
    final createdCell = sheet.cell(CellIndex.indexByString("A3"));
    createdCell.value =
        TextCellValue('Created At: ${DateTime.now().toFormattedDate3()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A4"), CellIndex.indexByString("G4"));

    // Add Category to headers
    final headers = [
      'Id',
      'Order',
      'Product',
      'Category',
      'Qty',
      'Price',
      'Total'
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

    for (var i = 0; i < itemSalesWithCategories.length; i++) {
      final item = itemSalesWithCategories[i];
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

      // Add category cell
      final categoryCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex));
      categoryCell.value = TextCellValue(item.categoryName ?? 'Uncategorized');
      categoryCell.cellStyle =
          CellStyle(horizontalAlign: HorizontalAlign.Center);

      final qtyCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex));
      qtyCell.value = item.quantity != null
          ? TextCellValue(item.quantity.toString())
          : TextCellValue('');
      qtyCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Center);

      final priceCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex));
      priceCell.value = TextCellValue(item.price?.currencyFormatRp ?? '');
      priceCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);

      final totalCell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex));
      totalCell.value = TextCellValue(
          (item.price != null && item.quantity != null)
              ? (item.price! * item.quantity!).currencyFormatRp
              : '');
      totalCell.cellStyle = CellStyle(horizontalAlign: HorizontalAlign.Right);
    }

    final footerRowIndex = itemSalesWithCategories.length + 8;
    sheet.merge(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex),
      CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: footerRowIndex),
    );
    final footerCell = sheet.cell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: footerRowIndex));
    footerCell.value = TextCellValue('Address: $outletAddress');

    // Adjust column widths
    sheet.setColumnWidth(0, 15.0);
    sheet.setColumnWidth(1, 15.0);
    sheet.setColumnWidth(2, 40.0);
    sheet.setColumnWidth(3, 25.0); // Category column width
    sheet.setColumnWidth(4, 15.0);
    sheet.setColumnWidth(5, 25.0);
    sheet.setColumnWidth(6, 25.0);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return HelperExcelService.saveExcel(
      name: 'seblak_sulthane_sales_report_$timestamp.xlsx',
      excel: excel,
    );
  }
}
