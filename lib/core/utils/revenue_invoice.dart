import 'dart:io';

import 'package:excel/excel.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:flutter/services.dart';

import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class RevenueInvoice {
  static late Font ttf;
  static Future<File> generatePdf(
    SummaryModel summaryModel,
    String searchDateFormatted,
  ) async {
    final pdf = Document();
    // var data = await rootBundle.load("assets/fonts/noto-sans.ttf");
    // ttf = Font.ttf(data);
    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();

    // Membuat objek Image dari gambar
    final image = pw.MemoryImage(bytes);

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(summaryModel, image, searchDateFormatted),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildTotal(summaryModel),
        ],
        footer: (context) => buildFooter(summaryModel),
      ),
    );

    return HelperPdfService.saveDocument(
      name:
          'Seblak Sulthane | Summary Sales Report | ${DateTime.now().millisecondsSinceEpoch}.pdf',
      pdf: pdf,
    );
  }

  static Widget buildHeader(
    SummaryModel invoice,
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

  static Widget buildTotal(SummaryModel summaryModel) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(
            title: 'Revenue',
            value: int.parse(summaryModel.totalRevenue!).currencyFormatRp,
            unite: true,
          ),
          Divider(),
          buildText(
            title: 'Sub Total',
            titleStyle: TextStyle(fontWeight: FontWeight.normal),
            value: int.parse(summaryModel.totalSubtotal!).currencyFormatRp,
            unite: true,
          ),
          buildText(
            title: 'Discount',
            titleStyle: TextStyle(fontWeight: FontWeight.normal),
            value:
                "- ${int.parse(summaryModel.totalDiscount!.replaceAll('.00', '')).currencyFormatRp}",
            unite: true,
            textStyle: TextStyle(
              color: PdfColor.fromHex('#FF0000'),
              fontWeight: FontWeight.bold,
            ),
          ),
          buildText(
            title: 'Tax',
            titleStyle: TextStyle(fontWeight: FontWeight.normal),
            value: "- ${int.parse(summaryModel.totalTax!).currencyFormatRp}",
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
            value: int.parse(summaryModel.totalServiceCharge!).currencyFormatRp,
            unite: true,
          ),
          Divider(),
          buildText(
            title: 'Total ',
            titleStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            value: summaryModel.total!.currencyFormatRp,
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

  static Widget buildFooter(SummaryModel summaryModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(
              title: 'Address',
              value:
                  'Jalan Melati No. 12, Mranggen, Demak, Central Java, 89568'),
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

  // Excel Generation
  static Future<File> generateExcel(
    SummaryModel summaryModel,
    String searchDateFormatted,
  ) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Summary Sales Report'];

    // Add Header with company info
    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("B1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value = TextCellValue('Seblak Sulthane | Summary Sales Report');
    headerCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 16,
      horizontalAlign: HorizontalAlign.Center,
    );

    // Add date information
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

    // Add empty row for spacing
    final startRow = 5;

    // Add Revenue
    final revenueCell = sheet.cell(CellIndex.indexByString("A$startRow"));
    revenueCell.value = TextCellValue('Revenue');
    revenueCell.cellStyle = CellStyle(bold: true);

    final revenueTotalCell = sheet.cell(CellIndex.indexByString("B$startRow"));
    revenueTotalCell.value =
        TextCellValue(int.parse(summaryModel.totalRevenue!).currencyFormatRp);
    revenueTotalCell.cellStyle = CellStyle(bold: true);

    // Add separator line
    sheet.merge(CellIndex.indexByString("A${startRow + 1}"),
        CellIndex.indexByString("B${startRow + 1}"));

    // Add Subtotal
    final subtotalCell =
        sheet.cell(CellIndex.indexByString("A${startRow + 2}"));
    subtotalCell.value = TextCellValue('Subtotal');

    final subtotalValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 2}"));
    subtotalValueCell.value =
        TextCellValue(int.parse(summaryModel.totalSubtotal!).currencyFormatRp);

    // Add Discount
    final discountCell =
        sheet.cell(CellIndex.indexByString("A${startRow + 3}"));
    discountCell.value = TextCellValue('Discount');

    final discountValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 3}"));
    discountValueCell.value = TextCellValue(
        "- ${int.parse(summaryModel.totalDiscount!.replaceAll('.00', '')).currencyFormatRp}");

    // Add Tax
    final taxCell = sheet.cell(CellIndex.indexByString("A${startRow + 4}"));
    taxCell.value = TextCellValue('Tax');

    final taxValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 4}"));
    taxValueCell.value = TextCellValue(
        "- ${int.parse(summaryModel.totalTax!).currencyFormatRp}");

    // Add Service Charge
    final serviceCell = sheet.cell(CellIndex.indexByString("A${startRow + 5}"));
    serviceCell.value = TextCellValue('Service Charge');

    final serviceValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 5}"));
    serviceValueCell.value = TextCellValue(
        int.parse(summaryModel.totalServiceCharge!).currencyFormatRp);

    // Add separator line
    sheet.merge(CellIndex.indexByString("A${startRow + 6}"),
        CellIndex.indexByString("B${startRow + 6}"));

    // Add Total
    final totalCell = sheet.cell(CellIndex.indexByString("A${startRow + 7}"));
    totalCell.value = TextCellValue('TOTAL');
    totalCell.cellStyle = CellStyle(bold: true);

    final totalValueCell =
        sheet.cell(CellIndex.indexByString("B${startRow + 7}"));
    totalValueCell.value = TextCellValue(summaryModel.total!.currencyFormatRp);
    totalValueCell.cellStyle = CellStyle(bold: true);

    // Add Footer
    final footerRow = startRow + 9;
    sheet.merge(
      CellIndex.indexByString("A$footerRow"),
      CellIndex.indexByString("B$footerRow"),
    );
    final footerCell = sheet.cell(CellIndex.indexByString("A$footerRow"));
    footerCell.value = TextCellValue(
        'Address: Jalan Melati No. 12, Mranggen, Demak, Central Java, 89568');

    // Set column widths
    sheet.setColumnWidth(0, 25.0); // Description column
    sheet.setColumnWidth(1, 25.0); // Amount column

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_summary_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
