import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:seblak_sulthane_app/core/core.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/helper_excel_service.dart';
import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';

class RevenueInvoice {
  static late pw.Font ttf;

  static Future<int?> _fetchOutletIdFromProfile() async {
    try {
      final authRemoteDatasource = AuthRemoteDatasource();
      final result = await authRemoteDatasource.getProfile();

      int? outletId;
      result.fold(
        (error) {
          print('Gagal mengambil profil: $error');
          return null;
        },
        (user) {
          outletId = user.outletId;
        },
      );

      return outletId;
    } catch (e) {
      print('Terjadi kesalahan saat mengambil profil: $e');
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
      print('Gagal mengambil alamat outlet: $e');
      return 'Seblak Sulthane';
    }
  }

  static double parseNumericValue(dynamic value) {
    if (value == null) return 0.0;

    if (value is double) return value;
    if (value is int) return value.toDouble();

    if (value is String) {
      try {
        String cleanValue = value
            .replaceAll('Rp', '')
            .replaceAll('.', '')
            .replaceAll(',', '.')
            .trim();
        return double.parse(cleanValue);
      } catch (e) {
        return 0.0;
      }
    }

    return 0.0;
  }

  static String safeGetCurrencyFormat(dynamic value) {
    if (value == null) return '0'.currencyFormatRp;

    if (value is int) {
      return value.toString().currencyFormatRp;
    }

    if (value is double) {
      return value.toInt().toString().currencyFormatRp;
    }

    if (value is String) {
      try {
        String cleanValue = value
            .replaceAll('Rp', '')
            .replaceAll('.', '')
            .replaceAll(',', '.')
            .trim();
        return double.parse(cleanValue).toInt().toString().currencyFormatRp;
      } catch (e) {
        try {
          return int.parse(value).toString().currencyFormatRp;
        } catch (e) {
          return '0'.currencyFormatRp;
        }
      }
    }

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
          'Seblak Sulthane | Laporan Ringkasan Penjualan | ${DateTime.now().millisecondsSinceEpoch}.pdf',
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
            pw.Text('Seblak Sulthane | Laporan Ringkasan Penjualan',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
            pw.Text(
              "Data: $searchDateFormatted",
            ),
            pw.Text(
              'Dibuat Pada: ${DateTime.now().toFormattedDate3()}',
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

  static int parseIntFromDynamic(dynamic value) {
    try {
      if (value == null) return 0;
      if (value is int) return value;
      if (value is double) return value.toInt();
      if (value is String) {
        String cleanValue = value
            .replaceAll('Rp', '')
            .replaceAll('.', '')
            .replaceAll(',', '.')
            .trim();
        return double.parse(cleanValue).toInt();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  static pw.Widget buildFinancialSummary(EnhancedSummaryData summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Ringkasan Keuangan',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildText(
          title: 'Pendapatan',
          value: parseIntFromDynamic(summary.totalRevenue)
              .toString()
              .currencyFormatRp,
          unite: true,
        ),
        pw.Divider(),
        buildText(
          title: 'Subtotal',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: parseIntFromDynamic(summary.totalSubtotal)
              .toString()
              .currencyFormatRp,
          unite: true,
        ),
        buildText(
          title: 'Diskon',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value:
              "- ${parseIntFromDynamic(summary.totalDiscount).toString().currencyFormatRp}",
          unite: true,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        buildText(
          title: 'Pajak',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value:
              "- ${parseIntFromDynamic(summary.totalTax).toString().currencyFormatRp}",
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
            fontWeight: pw.FontWeight.bold,
          ),
          unite: true,
        ),
        buildText(
          title: 'Biaya Layanan',
          titleStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.normal,
          ),
          value: parseIntFromDynamic(summary.totalServiceCharge)
              .toString()
              .currencyFormatRp,
          unite: true,
        ),
      ],
    );
  }

  static pw.Widget buildCashFlowSummary(EnhancedSummaryData summary) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Arus Kas Harian',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildText(
          title: 'Saldo Awal',
          value: safeGetCurrencyFormat(summary.openingBalance),
          unite: true,
        ),
        pw.Divider(),
        buildText(
          title: 'Pengeluaran',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: "- ${safeGetCurrencyFormat(summary.expenses)}",
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#FF0000'),
          ),
          unite: true,
        ),
        buildText(
          title: 'Penjualan Tunai',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.getCashSalesAsInt().toString().currencyFormatRp,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#008000'),
          ),
          unite: true,
        ),
        buildText(
          title: 'Penjualan QRIS',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.getQrisSalesAsInt().toString().currencyFormatRp,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#008000'),
          ),
          unite: true,
        ),
        buildText(
          title: 'Biaya QRIS',
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
          title: 'Penjualan Minuman',
          titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.normal),
          value: summary.getBeverageSalesAsInt().toString().currencyFormatRp,
          textStyle: pw.TextStyle(
            color: PdfColor.fromHex('#008000'),
          ),
          unite: true,
        ),
        pw.Divider(),
        buildText(
          title: 'Saldo Akhir',
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
        pw.Text('Metode Pembayaran',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        if (paymentMethods.cash != null) ...[
          buildText(
            title: 'Tunai (${paymentMethods.cash!.count} transaksi)',
            value: paymentMethods.cash!
                .getTotalAsInt()
                .toString()
                .currencyFormatRp,
            unite: true,
          ),
          buildText(
            title: 'Biaya QRIS Tunai',
            value: paymentMethods.cash!.qrisFees != null
                ? "- ${safeGetCurrencyFormat(paymentMethods.cash!.qrisFees)}"
                : "- Rp 0,00",
            unite: true,
            textStyle: pw.TextStyle(
              color: PdfColor.fromHex('#FF0000'),
            ),
          ),
        ],
        if (paymentMethods.cash != null && paymentMethods.qris != null)
          pw.Divider(),
        if (paymentMethods.qris != null) ...[
          buildText(
            title: 'QRIS (${paymentMethods.qris!.count} transaksi)',
            value: paymentMethods.qris!
                .getTotalAsInt()
                .toString()
                .currencyFormatRp,
            unite: true,
          ),
          buildText(
            title: 'Biaya QRIS',
            value: paymentMethods.qris!.qrisFees != null
                ? "- ${safeGetCurrencyFormat(paymentMethods.qris!.qrisFees)}"
                : "- Rp 0,00",
            unite: true,
            textStyle: pw.TextStyle(
              color: PdfColor.fromHex('#FF0000'),
            ),
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
      pw.Text('Rincian Harian',
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
              pw.Text('Tanggal: ${day.date}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 4),
              buildSimpleText(
                title: 'Saldo Awal:',
                value: safeGetCurrencyFormat(day.openingBalance),
              ),
              buildSimpleText(
                title: 'Pengeluaran:',
                value: "- ${safeGetCurrencyFormat(day.expenses)}",
              ),
              buildSimpleText(
                title: 'Penjualan Tunai:',
                value: day.getCashSalesAsInt().toString().currencyFormatRp,
              ),
              buildSimpleText(
                title: 'Penjualan QRIS:',
                value: day.getQrisSalesAsInt().toString().currencyFormatRp,
              ),
              buildSimpleText(
                title: 'Biaya QRIS:',
                value: day.qrisFee != null
                    ? "- ${safeGetCurrencyFormat(day.qrisFee)}"
                    : "- Rp 0,00",
              ),
              buildSimpleText(
                title: 'Total Penjualan:',
                value: safeGetCurrencyFormat(day.totalSales),
              ),
              buildSimpleText(
                title: 'Saldo Akhir:',
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
          buildSimpleText(title: 'Alamat', value: outletAddress),
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
    final Sheet sheet = excel['Laporan Ringkasan Penjualan'];

    outletId ??= await _fetchOutletIdFromProfile();
    outletId ??= 1;

    final String outletAddress = await _getOutletAddress(outletId);

    // Title and metadata
    sheet.merge(CellIndex.indexByString("A1"), CellIndex.indexByString("B1"));
    final headerCell = sheet.cell(CellIndex.indexByString("A1"));
    headerCell.value =
        TextCellValue('Seblak Sulthane | Laporan Ringkasan Penjualan');
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
        TextCellValue('Dibuat Pada: ${DateTime.now().toFormattedDate3()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
    );

    // Financial Summary
    int currentRow = 5;

    sheet.merge(CellIndex.indexByString("A$currentRow"),
        CellIndex.indexByString("B$currentRow"));
    final financialHeaderCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    financialHeaderCell.value = TextCellValue('Ringkasan Keuangan');
    financialHeaderCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 14,
      horizontalAlign: HorizontalAlign.Left,
    );
    currentRow += 2;

    // Revenue
    final revenueCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    revenueCell.value = TextCellValue('Pendapatan');
    revenueCell.cellStyle = CellStyle(bold: true);

    final revenueTotalCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    revenueTotalCell.value = TextCellValue(
        parseIntFromDynamic(summaryModel.totalRevenue)
            .toString()
            .currencyFormatRp);
    revenueTotalCell.cellStyle = CellStyle(bold: true);
    currentRow++;

    // Subtotal
    final subtotalCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    subtotalCell.value = TextCellValue('Subtotal');

    final subtotalValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    subtotalValueCell.value = TextCellValue(
        parseIntFromDynamic(summaryModel.totalSubtotal)
            .toString()
            .currencyFormatRp);
    currentRow++;

    // Discount
    final discountCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    discountCell.value = TextCellValue('Diskon');

    final discountValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    discountValueCell.value = TextCellValue(
        "- ${parseIntFromDynamic(summaryModel.totalDiscount).toString().currencyFormatRp}");
    currentRow++;

    // Tax
    final taxCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    taxCell.value = TextCellValue('Pajak');

    final taxValueCell = sheet.cell(CellIndex.indexByString("B$currentRow"));
    taxValueCell.value = TextCellValue(
        "- ${parseIntFromDynamic(summaryModel.totalTax).toString().currencyFormatRp}");
    currentRow++;

    // Service Charge
    final serviceCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    serviceCell.value = TextCellValue('Biaya Layanan');

    final serviceValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    serviceValueCell.value = TextCellValue(
        parseIntFromDynamic(summaryModel.totalServiceCharge)
            .toString()
            .currencyFormatRp);
    currentRow += 2;

    // Daily Cash Flow
    sheet.merge(CellIndex.indexByString("A$currentRow"),
        CellIndex.indexByString("B$currentRow"));
    final cashFlowHeaderCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    cashFlowHeaderCell.value = TextCellValue('Arus Kas Harian');
    cashFlowHeaderCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 14,
      horizontalAlign: HorizontalAlign.Left,
    );
    currentRow += 2;

    // Opening Balance
    final openingBalanceCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    openingBalanceCell.value = TextCellValue('Saldo Awal');

    final openingBalanceValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    openingBalanceValueCell.value =
        TextCellValue(safeGetCurrencyFormat(summaryModel.openingBalance));
    currentRow++;

    // Expenses
    final expensesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    expensesCell.value = TextCellValue('Pengeluaran');

    final expensesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    expensesValueCell.value =
        TextCellValue("- ${safeGetCurrencyFormat(summaryModel.expenses)}");
    currentRow++;

    // Cash Sales
    final cashSalesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    cashSalesCell.value = TextCellValue('Penjualan Tunai');

    final cashSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    cashSalesValueCell.value = TextCellValue(
        summaryModel.getCashSalesAsInt().toString().currencyFormatRp);
    currentRow++;

    // QRIS Sales
    final qrisSalesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    qrisSalesCell.value = TextCellValue('Penjualan QRIS');

    final qrisSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    qrisSalesValueCell.value = TextCellValue(
        summaryModel.getQrisSalesAsInt().toString().currencyFormatRp);
    currentRow++;

    // QRIS Fee
    final qrisFeeCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    qrisFeeCell.value = TextCellValue('Biaya QRIS');

    final qrisFeeValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    qrisFeeValueCell.value = TextCellValue(summaryModel.qrisFee != null
        ? "- ${safeGetCurrencyFormat(summaryModel.qrisFee)}"
        : "- Rp 0,00");
    currentRow++;

    // Beverage Sales
    final beverageSalesCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    beverageSalesCell.value = TextCellValue('Penjualan Minuman');

    final beverageSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    beverageSalesValueCell.value = TextCellValue(
        summaryModel.getBeverageSalesAsInt().toString().currencyFormatRp);
    currentRow++;

    // Closing Balance
    final closingBalanceCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    closingBalanceCell.value = TextCellValue('Saldo Akhir');
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
      paymentMethodsHeaderCell.value = TextCellValue('Metode Pembayaran');
      paymentMethodsHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow += 2;

      if (summaryModel.paymentMethods?.cash != null) {
        final cashCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
        cashCell.value = TextCellValue(
            'Tunai (${summaryModel.paymentMethods!.cash!.count} transaksi)');

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
        cashFeesCell.value = TextCellValue('Biaya QRIS Tunai');

        final cashFeesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        cashFeesValueCell.value = TextCellValue(summaryModel
                    .paymentMethods!.cash!.qrisFees !=
                null
            ? "- ${safeGetCurrencyFormat(summaryModel.paymentMethods!.cash!.qrisFees)}"
            : "- Rp 0,00");
        currentRow++;
      }
      if (summaryModel.paymentMethods?.qris != null) {
        final qrisCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
        qrisCell.value = TextCellValue(
            'QRIS (${summaryModel.paymentMethods!.qris!.count} transaksi)');

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
        qrisFeesCell.value = TextCellValue('Biaya QRIS');

        final qrisFeesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        qrisFeesValueCell.value = TextCellValue(summaryModel
                    .paymentMethods!.qris!.qrisFees !=
                null
            ? "- ${safeGetCurrencyFormat(summaryModel.paymentMethods!.qris!.qrisFees)}"
            : "- Rp 0,00");
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
      breakdownHeaderCell.value = TextCellValue('Rincian Harian');
      breakdownHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow += 2;

      // Set headers for breakdown table
      final headers = [
        'Tanggal',
        'Saldo Awal',
        'Pengeluaran',
        'Penjualan Tunai',
        'Penjualan QRIS',
        'Biaya QRIS',
        'Total Penjualan',
        'Saldo Akhir'
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
    footerCell.value = TextCellValue('Alamat: $outletAddress');

    // Set column widths
    sheet.setColumnWidth(0, 35.0);
    sheet.setColumnWidth(1, 25.0);
    for (var i = 2; i < 8; i++) {
      sheet.setColumnWidth(i, 20.0);
    }

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_laporan_ringkasan_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
