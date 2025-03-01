import 'dart:io';

import 'package:excel/excel.dart';
import 'package:seblak_sulthane_app/core/core.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:flutter/services.dart';

import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RevenueInvoice {
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

      // Debug: print all outlets as a list
      print('All outlets: $allOutlets');

      final outlet = await outletDataSource.getOutletById(outletId);

      if (outlet != null) {
        print('Found outlet for ID $outletId: $outlet');
      }

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
      SummaryData summaryModel, String searchDateFormatted,
      {int? outletId}) async {
    final pdf = Document();

    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();

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
          buildHeader(summaryModel, image, searchDateFormatted),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildTotal(summaryModel),
        ],
        footer: (context) => buildFooter(summaryModel, outletAddress),
      ),
    );

    return HelperPdfService.saveDocument(
      name:
          'Seblak Sulthane | Summary Sales Report | ${DateTime.now().millisecondsSinceEpoch}.pdf',
      pdf: pdf,
    );
  }

  static Widget buildHeader(
    SummaryData invoice,
    MemoryImage image,
    String searchDateFormatted,
  ) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Text('Seblak Sulthane | Summary Sales Report',
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

  // Safely parse a string to an integer
  static int safeParseInt(String value) {
    try {
      // Try to parse as int first
      return int.parse(value);
    } catch (e) {
      try {
        // If that fails, try to parse as double and convert to int
        return double.parse(value).toInt();
      } catch (e) {
        // If all parsing fails, return 0
        print('Failed to parse to int: $value');
        return 0;
      }
    }
  }

  static Widget buildTotal(SummaryData summaryModel) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(
            title: 'Revenue',
            value: safeParseInt(summaryModel.totalRevenue).currencyFormatRp,
            unite: true,
          ),
          Divider(),
          buildText(
            title: 'Sub Total',
            titleStyle: TextStyle(fontWeight: FontWeight.normal),
            value: safeParseInt(summaryModel.totalSubtotal).currencyFormatRp,
            unite: true,
          ),
          buildText(
            title: 'Discount',
            titleStyle: TextStyle(fontWeight: FontWeight.normal),
            value:
                "- ${safeParseInt(summaryModel.totalDiscount.replaceAll('.00', '')).currencyFormatRp}",
            unite: true,
            textStyle: TextStyle(
              color: PdfColor.fromHex('#FF0000'),
              fontWeight: FontWeight.bold,
            ),
          ),
          buildText(
            title: 'Tax',
            titleStyle: TextStyle(fontWeight: FontWeight.normal),
            value: "- ${safeParseInt(summaryModel.totalTax).currencyFormatRp}",
            textStyle: TextStyle(
              color: PdfColor.fromHex('#FF0000'),
              fontWeight: FontWeight.bold,
            ),
            unite: true,
          ),
          buildText(
            title: 'Service Charge',
            titleStyle: TextStyle(
              fontWeight: FontWeight.normal,
            ),
            value: safeParseInt(summaryModel.totalServiceCharge.toString())
                .currencyFormatRp,
            unite: true,
          ),
          Divider(),
          buildText(
            title: 'Total ',
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            value: safeParseInt(summaryModel.total.toString()).currencyFormatRp,
            unite: true,
          ),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Container(height: 1, color: PdfColors.grey400),
          SizedBox(height: 0.5 * PdfPageFormat.mm),
          Container(height: 1, color: PdfColors.grey400),
        ],
      ),
    );
  }

  static Widget buildFooter(SummaryData summaryModel, String outletAddress) =>
      Column(
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
    TextStyle? textStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);
    final style2 = textStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: style2),
        ],
      ),
    );
  }

  static Future<File> generateExcel(
      SummaryData summaryModel, String searchDateFormatted,
      {int? outletId}) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Summary Sales Report'];

    // If outletId is not provided, try to fetch it from profile
    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1; // Default to 1 if still null

    print('Using outletId: $outletId for Excel generation');

    // Get outlet address
    final String outletAddress = await _getOutletAddress(outletId);
    print('Using address: $outletAddress for Excel');

    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("B1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value = TextCellValue('Seblak Sulthane | Summary Sales Report');
    headerCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("B2"));
    final dateCell = sheet.cell(CellIndex.indexByString("A2"));
    dateCell.value = TextCellValue('Data: $searchDateFormatted');
    dateCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    sheet.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("B3"));
    final createdCell = sheet.cell(CellIndex.indexByString("A3"));
    createdCell.value =
        TextCellValue('Created At: ${DateTime.now().toFormattedDate3()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    final startRow = 5;

    final revenueCell = sheet.cell(CellIndex.indexByString("A$startRow"));
    revenueCell.value = TextCellValue('Revenue');
    revenueCell.cellStyle = CellStyle(bold: true);

    final revenueTotalCell = sheet.cell(CellIndex.indexByString("B$startRow"));
    revenueTotalCell.value =
        TextCellValue(safeParseInt(summaryModel.totalRevenue).currencyFormatRp);
    revenueTotalCell.cellStyle = CellStyle(bold: true);

    sheet.merge(CellIndex.indexByString("A${startRow + 1}"),
        CellIndex.indexByString("B${startRow + 1}"));

    final subtotalCell =
        sheet.cell(CellIndex.indexByString("A${startRow + 2}"));
    subtotalCell.value = TextCellValue('Subtotal');

    final subtotalValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 2}"));
    subtotalValueCell.value = TextCellValue(
        safeParseInt(summaryModel.totalSubtotal).currencyFormatRp);

    final discountCell =
        sheet.cell(CellIndex.indexByString("A${startRow + 3}"));
    discountCell.value = TextCellValue('Discount');

    final discountValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 3}"));
    discountValueCell.value = TextCellValue(
        "- ${safeParseInt(summaryModel.totalDiscount.replaceAll('.00', '')).currencyFormatRp}");

    final taxCell = sheet.cell(CellIndex.indexByString("A${startRow + 4}"));
    taxCell.value = TextCellValue('Tax');

    final taxValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 4}"));
    taxValueCell.value = TextCellValue(
        "- ${safeParseInt(summaryModel.totalTax).currencyFormatRp}");

    final serviceCell = sheet.cell(CellIndex.indexByString("A${startRow + 5}"));
    serviceCell.value = TextCellValue('Service Charge');

    final serviceValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 5}"));
    serviceValueCell.value = TextCellValue(
        safeParseInt(summaryModel.totalServiceCharge.toString())
            .currencyFormatRp);

    sheet.merge(CellIndex.indexByString("A${startRow + 6}"),
        CellIndex.indexByString("B${startRow + 6}"));

    final totalCell = sheet.cell(CellIndex.indexByString("A${startRow + 7}"));
    totalCell.value = TextCellValue('TOTAL');
    totalCell.cellStyle = CellStyle(bold: true);

    final totalValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 7}"));
    totalValueCell.value = TextCellValue(
        safeParseInt(summaryModel.total.toString()).currencyFormatRp);
    totalValueCell.cellStyle = CellStyle(bold: true);

    final footerRow = startRow + 9;
    sheet.merge(
      CellIndex.indexByString("A$footerRow"),
      CellIndex.indexByString("B$footerRow"),
    );
    final footerCell = sheet.cell(CellIndex.indexByString("A$footerRow"));
    footerCell.value = TextCellValue('Address: $outletAddress');

    sheet.setColumnWidth(0, 25.0);
    sheet.setColumnWidth(1, 25.0);

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_summary_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
