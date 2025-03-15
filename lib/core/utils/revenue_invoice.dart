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
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class RevenueInvoice {
  static late pw.Font ttf;

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
      final outlet = await outletDataSource.getOutletById(outletId);

      if (outlet != null) {
        String address = '';

        // Add address1 if available
        if (outlet.address1 != null && outlet.address1!.isNotEmpty) {
          address = outlet.address1!;
        }

        // Add address2 if available
        if (outlet.address2 != null && outlet.address2!.isNotEmpty) {
          if (address.isNotEmpty) {
            address += ', '; // Add separator if address1 was present
          }
          address += outlet.address2!;
        }

        // Return the combined address or default if both are empty
        return address.isNotEmpty ? address : 'Seblak Sulthane';
      }

      // If specific outlet not found, try to get the first outlet
      final allOutlets = await outletDataSource.getAllOutlets();
      if (allOutlets.isNotEmpty) {
        String address = '';
        final firstOutlet = allOutlets.first;

        // Add address1 if available
        if (firstOutlet.address1 != null && firstOutlet.address1!.isNotEmpty) {
          address = firstOutlet.address1!;
        }

        // Add address2 if available
        if (firstOutlet.address2 != null && firstOutlet.address2!.isNotEmpty) {
          if (address.isNotEmpty) {
            address += ', '; // Add separator if address1 was present
          }
          address += firstOutlet.address2!;
        }

        // Return the combined address or default if both are empty
        return address.isNotEmpty ? address : 'Seblak Sulthane';
      }

      return 'Seblak Sulthane'; // Default fallback
    } catch (e) {
      print('Error fetching outlet address: $e');
      return 'Seblak Sulthane'; // Default fallback on error
    }
  }

  // Helper method to safely parse any numeric value to string with currency format
  static String safeGetCurrencyFormat(dynamic value) {
    if (value == null) return '0'.currencyFormatRp;

    if (value is int) {
      return value.toString().currencyFormatRp;
    }

    if (value is double) {
      return value.toString().currencyFormatRp;
    }

    if (value is String) {
      try {
        // Try parsing as double first to handle decimal values
        return double.parse(value).toString().currencyFormatRp;
      } catch (e) {
        try {
          // If not a double, try as integer
          return int.parse(value).toString().currencyFormatRp;
        } catch (e) {
          // If all parsing fails, return default
          return '0'.currencyFormatRp;
        }
      }
    }

    // For any other type
    return '0'.currencyFormatRp;
  }

  static Future<File> generatePdf(
      EnhancedSummaryData summaryModel, String searchDateFormatted,
      {int? outletId}) async {
    final pdf = pw.Document();

    final ByteData dataImage = await rootBundle.load('assets/images/logo.png');
    final Uint8List bytes = dataImage.buffer.asUint8List();

    final image = pw.MemoryImage(bytes);

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          buildHeader(summaryModel, image, searchDateFormatted),
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          buildFinancialSummary(summaryModel),
          pw.SizedBox(height: 1 * PdfPageFormat.cm),
          buildCashFlowSummary(summaryModel),
          if (summaryModel.paymentMethods != null) ...[
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
            buildPaymentMethods(summaryModel),
          ],
          if (summaryModel.dailyBreakdown != null &&
              summaryModel.dailyBreakdown!.isNotEmpty) ...[
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
            buildDailyBreakdown(summaryModel),
          ],
        ],
        footer: (context) => buildFooter(outletAddress),
      ),
    );

    return HelperPdfService.saveDocument(
      name:
          'Seblak Sulthane | Summary Sales Report | ${DateTime.now().millisecondsSinceEpoch}.pdf',
      pdf: pdf,
    );
  }

  static pw.Widget buildHeader(
    EnhancedSummaryData summary,
    pw.MemoryImage image,
    String searchDateFormatted,
  ) =>
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
            pw.Text('Seblak Sulthane | Summary Sales Report',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
            pw.Text(
              "Data: $searchDateFormatted",
            ),
            pw.Text(
              'Created At: ${DateTime.now().toFormattedDate3()}',
            ),
          ],
        ),
        pw.Image(
          image,
          width: 80.0,
          height: 80.0,
          fit: pw.BoxFit.fill,
        ),
      ]);

  static int safeParseInt(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      try {
        return double.parse(value).toInt();
      } catch (e) {
        return 0;
      }
    }
  }

  static pw.Widget buildFinancialSummary(EnhancedSummaryData summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Financial Summary',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildText(
          title: 'Revenue',
          value: safeParseInt(summary.totalRevenue).currencyFormatRp,
          unite: true,
        ),
        pw.Divider(),
        buildText(
          title: 'Sub Total',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: safeParseInt(summary.totalSubtotal).currencyFormatRp,
          unite: true,
        ),
        buildText(
          title: 'Discount',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value:
              "- ${safeParseInt(summary.totalDiscount.replaceAll('.00', '')).currencyFormatRp}",
          unite: true,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        buildText(
          title: 'Tax',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: "- ${safeParseInt(summary.totalTax).currencyFormatRp}",
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
            fontWeight: pw.FontWeight.bold,
          ),
          unite: true,
        ),
        buildText(
          title: 'Service Charge',
          titleStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.normal,
          ),
          value: summary.totalServiceCharge is num
              ? (summary.totalServiceCharge as num).toInt().currencyFormatRp
              : summary.totalServiceCharge is String
                  ? safeParseInt(summary.totalServiceCharge as String)
                      .currencyFormatRp
                  : '0'.currencyFormatRp,
          unite: true,
        ),
      ],
    );
  }

  static pw.Widget buildCashFlowSummary(EnhancedSummaryData summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Daily Cash Flow',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildText(
          title: 'Opening Balance',
          value: safeGetCurrencyFormat(summary.openingBalance),
          unite: true,
        ),
        pw.Divider(),
        buildText(
          title: 'Expenses',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: safeGetCurrencyFormat(summary.expenses),
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
          ),
          unite: true,
        ),
        buildText(
          title: 'Cash Sales',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.getCashSalesAsInt().toString().currencyFormatRp,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#008000'),
          ),
          unite: true,
        ),
        buildText(
          title: 'QRIS Sales',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.getQrisSalesAsInt().toString().currencyFormatRp,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#008000'),
          ),
          unite: true,
        ),
        // Add QRIS Fee
        buildText(
          title: 'QRIS Fee',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.qrisFee != null
              ? "- ${safeGetCurrencyFormat(summary.qrisFee)}"
              : "- Rp 0,00",
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
          ),
          unite: true,
        ),
        buildText(
          title: 'Beverage Sales',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.getBeverageSalesAsInt().toString().currencyFormatRp,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#008000'),
          ),
          unite: true,
        ),
        pw.Divider(),
        buildText(
          title: 'Closing Balance',
          titleStyle: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
          value: safeGetCurrencyFormat(summary.closingBalance),
          unite: true,
        ),
      ],
    );
  }

  static pw.Widget buildPaymentMethods(EnhancedSummaryData summary) {
    final paymentMethods = summary.paymentMethods;
    if (paymentMethods == null) return pw.Container();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Payment Methods',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        if (paymentMethods.cash != null) ...[
          buildText(
            title: 'Cash (${paymentMethods.cash!.count} transactions)',
            value: paymentMethods.cash!
                .getTotalAsInt()
                .toString()
                .currencyFormatRp,
            unite: true,
          ),
          // Add Cash QRIS Fees (usually 0)
          buildText(
            title: 'Cash QRIS Fees',
            value: paymentMethods.cash!.qrisFees != null
                ? safeGetCurrencyFormat(paymentMethods.cash!.qrisFees)
                : "Rp 0,00",
            unite: true,
          ),
        ],
        if (paymentMethods.cash != null && paymentMethods.qris != null)
          pw.Divider(),
        if (paymentMethods.qris != null) ...[
          buildText(
            title: 'QRIS (${paymentMethods.qris!.count} transactions)',
            value: paymentMethods.qris!
                .getTotalAsInt()
                .toString()
                .currencyFormatRp,
            unite: true,
          ),
          // Add QRIS Fees
          buildText(
            title: 'QRIS Fees',
            value: paymentMethods.qris!.qrisFees != null
                ? safeGetCurrencyFormat(paymentMethods.qris!.qrisFees)
                : "Rp 0,00",
            unite: true,
          ),
        ],
      ],
    );
  }

  static pw.Widget buildDailyBreakdown(EnhancedSummaryData summary) {
    final dailyBreakdown = summary.dailyBreakdown;
    if (dailyBreakdown == null || dailyBreakdown.isEmpty) return pw.Container();

    final List<pw.Widget> breakdownWidgets = [];

    breakdownWidgets.add(
      pw.Text('Daily Breakdown',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
          )),
    );
    breakdownWidgets.add(pw.SizedBox(height: 0.5 * PdfPageFormat.cm));

    for (int i = 0; i < dailyBreakdown.length; i++) {
      final day = dailyBreakdown[i];

      breakdownWidgets.add(
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Date: ${day.date}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              buildSimpleText(
                title: 'Opening Balance:',
                value: safeGetCurrencyFormat(day.openingBalance),
              ),
              buildSimpleText(
                title: 'Expenses:',
                value: safeGetCurrencyFormat(day.expenses),
              ),
              buildSimpleText(
                title: 'Cash Sales:',
                value: day.getCashSalesAsInt().toString().currencyFormatRp,
              ),
              buildSimpleText(
                title: 'QRIS Sales:',
                value: day.getQrisSalesAsInt().toString().currencyFormatRp,
              ),
              // Add QRIS Fee
              buildSimpleText(
                title: 'QRIS Fee:',
                value: day.qrisFee != null
                    ? safeGetCurrencyFormat(day.qrisFee)
                    : "Rp 0,00",
              ),
              buildSimpleText(
                title: 'Total Sales:',
                value: safeGetCurrencyFormat(day.totalSales),
              ),
              buildSimpleText(
                title: 'Closing Balance:',
                value: safeGetCurrencyFormat(day.closingBalance),
              ),
            ],
          ),
        ),
      );

      if (i < dailyBreakdown.length - 1) {
        breakdownWidgets.add(pw.SizedBox(height: 0.3 * PdfPageFormat.cm));
      }
    }

    return pw.Column(children: breakdownWidgets);
  }

  static pw.Widget buildFooter(String outletAddress) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: outletAddress),
          pw.SizedBox(height: 1 * PdfPageFormat.mm),
        ],
      );

  static pw.Widget buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(value),
      ],
    );
  }

  static pw.Widget buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    pw.TextStyle? textStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);
    final style2 = textStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: style2),
        ],
      ),
    );
  }

  static Future<File> generateExcel(
      EnhancedSummaryData summaryModel, String searchDateFormatted,
      {int? outletId}) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Summary Sales Report'];

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    // Title and metadata
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

    // Financial Summary
    int currentRow = 5;

    sheet.merge(CellIndex.indexByString("A$currentRow"),
        CellIndex.indexByString("B$currentRow"));
    final financialHeaderCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    financialHeaderCell.value = TextCellValue('Financial Summary');
    financialHeaderCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 14,
      horizontalAlign: HorizontalAlign.Left,
    );
    currentRow += 2;

    // Revenue
    final revenueCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    revenueCell.value = TextCellValue('Revenue');
    revenueCell.cellStyle = CellStyle(bold: true);

    final revenueTotalCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    revenueTotalCell.value =
        TextCellValue(safeParseInt(summaryModel.totalRevenue).currencyFormatRp);
    revenueTotalCell.cellStyle = CellStyle(bold: true);
    currentRow++;

    // Subtotal
    final subtotalCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    subtotalCell.value = TextCellValue('Subtotal');

    final subtotalValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    subtotalValueCell.value = TextCellValue(
        safeParseInt(summaryModel.totalSubtotal).currencyFormatRp);
    currentRow++;

    // Discount
    final discountCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    discountCell.value = TextCellValue('Discount');

    final discountValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    discountValueCell.value = TextCellValue(
        "- ${safeParseInt(summaryModel.totalDiscount.replaceAll('.00', '')).currencyFormatRp}");
    currentRow++;

    // Tax
    final taxCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    taxCell.value = TextCellValue('Tax');

    final taxValueCell = sheet.cell(CellIndex.indexByString("B$currentRow"));
    taxValueCell.value = TextCellValue(
        "- ${safeParseInt(summaryModel.totalTax).currencyFormatRp}");
    currentRow++;

    // Service Charge
    final serviceCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    serviceCell.value = TextCellValue('Service Charge');

    final serviceValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    serviceValueCell.value = TextCellValue(
        summaryModel.totalServiceCharge is num
            ? (summaryModel.totalServiceCharge as num).toInt().currencyFormatRp
            : summaryModel.totalServiceCharge is String
                ? safeParseInt(summaryModel.totalServiceCharge as String)
                    .currencyFormatRp
                : '0'.currencyFormatRp);
    currentRow += 2;

    // Daily Cash Flow
    sheet.merge(CellIndex.indexByString("A$currentRow"),
        CellIndex.indexByString("B$currentRow"));
    final cashFlowHeaderCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    cashFlowHeaderCell.value = TextCellValue('Daily Cash Flow');
    cashFlowHeaderCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 14,
      horizontalAlign: HorizontalAlign.Left,
    );
    currentRow += 2;

    // Opening Balance
    final openingBalanceCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    openingBalanceCell.value = TextCellValue('Opening Balance');

    final openingBalanceValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    openingBalanceValueCell.value =
        TextCellValue(safeGetCurrencyFormat(summaryModel.openingBalance));
    currentRow++;

    // Expenses
    final expensesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    expensesCell.value = TextCellValue('Expenses');

    final expensesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    expensesValueCell.value =
        TextCellValue(safeGetCurrencyFormat(summaryModel.expenses));
    currentRow++;

    // Cash Sales
    final cashSalesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    cashSalesCell.value = TextCellValue('Cash Sales');

    final cashSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    cashSalesValueCell.value = TextCellValue(
        summaryModel.getCashSalesAsInt().toString().currencyFormatRp);
    currentRow++;

    // QRIS Sales
    final qrisSalesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    qrisSalesCell.value = TextCellValue('QRIS Sales');

    final qrisSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    qrisSalesValueCell.value = TextCellValue(
        summaryModel.getQrisSalesAsInt().toString().currencyFormatRp);
    currentRow++;

    // QRIS Fee
    final qrisFeeCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    qrisFeeCell.value = TextCellValue('QRIS Fee');

    final qrisFeeValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    qrisFeeValueCell.value = TextCellValue(summaryModel.qrisFee != null
        ? safeGetCurrencyFormat(summaryModel.qrisFee)
        : "Rp 0,00");
    currentRow++;

    // Beverage Sales
    final beverageSalesCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    beverageSalesCell.value = TextCellValue('Beverage Sales');

    final beverageSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    beverageSalesValueCell.value = TextCellValue(
        summaryModel.getBeverageSalesAsInt().toString().currencyFormatRp);
    currentRow++;

    // Closing Balance
    final closingBalanceCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    closingBalanceCell.value = TextCellValue('Closing Balance');
    closingBalanceCell.cellStyle = CellStyle(bold: true);

    final closingBalanceValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    closingBalanceValueCell.value =
        TextCellValue(safeGetCurrencyFormat(summaryModel.closingBalance));
    closingBalanceValueCell.cellStyle = CellStyle(bold: true);
    currentRow += 2;

    // Payment Methods
    if (summaryModel.paymentMethods != null) {
      sheet.merge(CellIndex.indexByString("A$currentRow"),
          CellIndex.indexByString("B$currentRow"));
      final paymentMethodsHeaderCell =
          sheet.cell(CellIndex.indexByString("A$currentRow"));
      paymentMethodsHeaderCell.value = TextCellValue('Payment Methods');
      paymentMethodsHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow += 2;

      if (summaryModel.paymentMethods?.cash != null) {
        final cashCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
        cashCell.value = TextCellValue(
            'Cash (${summaryModel.paymentMethods!.cash!.count} transactions)');

        final cashValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        cashValueCell.value = TextCellValue(summaryModel.paymentMethods!.cash!
            .getTotalAsInt()
            .toString()
            .currencyFormatRp);
        currentRow++;

        // Cash QRIS Fees
        final cashFeesCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        cashFeesCell.value = TextCellValue('Cash QRIS Fees');

        final cashFeesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        cashFeesValueCell.value = TextCellValue(summaryModel
                    .paymentMethods!.cash!.qrisFees !=
                null
            ? safeGetCurrencyFormat(summaryModel.paymentMethods!.cash!.qrisFees)
            : "Rp 0,00");
        currentRow++;
      }
      if (summaryModel.paymentMethods?.qris != null) {
        final qrisCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
        qrisCell.value = TextCellValue(
            'QRIS (${summaryModel.paymentMethods!.qris!.count} transactions)');

        final qrisValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        qrisValueCell.value = TextCellValue(summaryModel.paymentMethods!.qris!
            .getTotalAsInt()
            .toString()
            .currencyFormatRp);
        currentRow++;

        // QRIS Fees
        final qrisFeesCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        qrisFeesCell.value = TextCellValue('QRIS Fees');

        final qrisFeesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        qrisFeesValueCell.value = TextCellValue(summaryModel
                    .paymentMethods!.qris!.qrisFees !=
                null
            ? safeGetCurrencyFormat(summaryModel.paymentMethods!.qris!.qrisFees)
            : "Rp 0,00");
        currentRow++;
      }

      currentRow++;
    }

    // Daily Breakdown
    if (summaryModel.dailyBreakdown != null &&
        summaryModel.dailyBreakdown!.isNotEmpty) {
      sheet.merge(CellIndex.indexByString("A$currentRow"),
          CellIndex.indexByString("H$currentRow"));
      final breakdownHeaderCell =
          sheet.cell(CellIndex.indexByString("A$currentRow"));
      breakdownHeaderCell.value = TextCellValue('Daily Breakdown');
      breakdownHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow += 2;

      // Set headers for breakdown table
      final headers = [
        'Date',
        'Opening',
        'Expenses',
        'Cash Sales',
        'QRIS Sales',
        'QRIS Fee',
        'Total Sales',
        'Closing'
      ];
      for (var i = 0; i < headers.length; i++) {
        final headerCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: i, rowIndex: currentRow));
        headerCell.value = TextCellValue(headers[i]);
        headerCell.cellStyle = CellStyle(bold: true);
      }
      currentRow++;

      // Add data for each day
      for (var day in summaryModel.dailyBreakdown!) {
        final dateCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: currentRow));
        dateCell.value = TextCellValue(day.date);

        final openingCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: currentRow));
        openingCell.value =
            TextCellValue(safeGetCurrencyFormat(day.openingBalance));

        final expensesCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: currentRow));
        expensesCell.value = TextCellValue(safeGetCurrencyFormat(day.expenses));

        final cashSalesCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: currentRow));
        cashSalesCell.value =
            TextCellValue(day.getCashSalesAsInt().toString().currencyFormatRp);

        final qrisSalesCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: currentRow));
        qrisSalesCell.value =
            TextCellValue(day.getQrisSalesAsInt().toString().currencyFormatRp);

        final qrisFeeCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: currentRow));
        qrisFeeCell.value = TextCellValue(day.qrisFee != null
            ? safeGetCurrencyFormat(day.qrisFee)
            : "Rp 0,00");

        final totalSalesCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: currentRow));
        totalSalesCell.value =
            TextCellValue(safeGetCurrencyFormat(day.totalSales));

        final closingCell = sheet.cell(
            CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: currentRow));
        closingCell.value =
            TextCellValue(safeGetCurrencyFormat(day.closingBalance));

        currentRow++;
      }

      currentRow++;
    }

    // Footer with address
    sheet.merge(
      CellIndex.indexByString("A$currentRow"),
      CellIndex.indexByString("H$currentRow"),
    );
    final footerCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    footerCell.value = TextCellValue('Address: $outletAddress');

    // Set column widths
    sheet.setColumnWidth(0, 35.0);
    sheet.setColumnWidth(1, 25.0);
    for (var i = 2; i < 8; i++) {
      sheet.setColumnWidth(i, 20.0);
    }

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_summary_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
