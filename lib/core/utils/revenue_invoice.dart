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
          if (summaryModel.beverageBreakdown != null) ...[
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
            buildBeverageBreakdown(summaryModel),
          ],
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
        // Add Final Cash Closing
        if (summary.finalCashClosing != null) ...[
          buildText(
            title: 'Final Kas Akhir',
            titleStyle: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
            value: safeGetCurrencyFormat(summary.finalCashClosing),
            unite: true,
          ),
        ],
      ],
    );
  }

  static pw.Widget buildBeverageBreakdown(EnhancedSummaryData summary) {
    final beverageBreakdown = summary.beverageBreakdown;
    if (beverageBreakdown == null) return pw.Container();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Rincian Penjualan Minuman',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            )),
        pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
        if (beverageBreakdown.cash != null) ...[
          buildText(
            title: 'Tunai (${beverageBreakdown.cash!.getQuantityAsInt()} item)',
            value:
                safeGetCurrencyFormat(beverageBreakdown.cash!.getAmountAsInt()),
            unite: true,
            textStyle: pw.TextStyle(
              color: PdfColor.fromHex('#008000'),
            ),
          ),
        ],
        if (beverageBreakdown.qris != null) ...[
          buildText(
            title: 'QRIS (${beverageBreakdown.qris!.getQuantityAsInt()} item)',
            value:
                safeGetCurrencyFormat(beverageBreakdown.qris!.getAmountAsInt()),
            unite: true,
            textStyle: pw.TextStyle(
              color: PdfColor.fromHex('#008000'),
            ),
          ),
        ],
        if (beverageBreakdown.total != null) ...[
          pw.Divider(),
          buildText(
            title: 'Total (${beverageBreakdown.total!.quantity} item)',
            titleStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            value: beverageBreakdown.total!.amount.toString().currencyFormatRp,
            unite: true,
            textStyle: pw.TextStyle(
              color: PdfColor.fromHex('#008000'),
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
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

      List<pw.Widget> dayWidgets = [
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
      ];

      // Add Final Cash Closing if available
      if (day.finalCashClosing != null) {
        dayWidgets.add(
          buildSimpleText(
            title: 'Final Kas Akhir:',
            value: safeGetCurrencyFormat(day.finalCashClosing),
          ),
        );
      }

      // Add Beverage Breakdown if available
      if (day.beverageBreakdown != null) {
        dayWidgets.add(pw.SizedBox(height: 4));
        dayWidgets.add(
          pw.Text('Rincian Minuman:',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        );

        if (day.beverageBreakdown!.cash != null) {
          dayWidgets.add(
            buildSimpleText(
              title:
                  '- Tunai (${day.beverageBreakdown!.cash!.getQuantityAsInt()} item):',
              value: safeGetCurrencyFormat(
                  day.beverageBreakdown!.cash!.getAmountAsInt()),
            ),
          );
        }

        if (day.beverageBreakdown!.qris != null) {
          dayWidgets.add(
            buildSimpleText(
              title:
                  '- QRIS (${day.beverageBreakdown!.qris!.getQuantityAsInt()} item):',
              value: safeGetCurrencyFormat(
                  day.beverageBreakdown!.qris!.getAmountAsInt()),
            ),
          );
        }

        if (day.beverageBreakdown!.total != null) {
          dayWidgets.add(
            buildSimpleText(
              title:
                  '- Total (${day.beverageBreakdown!.total!.quantity} item):',
              value:
                  safeGetCurrencyFormat(day.beverageBreakdown!.total!.amount),
            ),
          );
        }
      }

      breakdownWidgets.add(
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey300),
            borderRadius: pw.BorderRadius.circular(5),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: dayWidgets,
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
      horizontalAlign: HorizontalAlign.Left,
    );

    sheet.merge(CellIndex.indexByString("A2"), CellIndex.indexByString("B2"));
    final dateCell = sheet.cell(CellIndex.indexByString("A2"));
    dateCell.value = TextCellValue('Data: $searchDateFormatted');
    dateCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Left,
    );

    sheet.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("B3"));
    final createdCell = sheet.cell(CellIndex.indexByString("A3"));
    createdCell.value =
        TextCellValue('Dibuat Pada: ${DateTime.now().toFormattedDate3()}');
    createdCell.cellStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Left,
    );

    int currentRow = 5;

    // Financial Summary
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
    currentRow++;

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
    subtotalCell.cellStyle = CellStyle();

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
    discountCell.cellStyle = CellStyle();

    final discountValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    discountValueCell.value = TextCellValue(
        "- ${parseIntFromDynamic(summaryModel.totalDiscount).toString().currencyFormatRp}");
    discountValueCell.cellStyle = CellStyle(
      bold: true,
    );
    currentRow++;

    // Tax
    final taxCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    taxCell.value = TextCellValue('Pajak');
    taxCell.cellStyle = CellStyle();

    final taxValueCell = sheet.cell(CellIndex.indexByString("B$currentRow"));
    taxValueCell.value = TextCellValue(
        "- ${parseIntFromDynamic(summaryModel.totalTax).toString().currencyFormatRp}");
    taxValueCell.cellStyle = CellStyle(
      bold: true,
    );
    currentRow++;

    // Service Charge
    final serviceCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    serviceCell.value = TextCellValue('Biaya Layanan');
    serviceCell.cellStyle = CellStyle();

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
    currentRow++;

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
    expensesCell.cellStyle = CellStyle();

    final expensesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    expensesValueCell.value =
        TextCellValue("- ${safeGetCurrencyFormat(summaryModel.expenses)}");
    expensesValueCell.cellStyle = CellStyle();
    currentRow++;

    // Cash Sales
    final cashSalesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    cashSalesCell.value = TextCellValue('Penjualan Tunai');
    cashSalesCell.cellStyle = CellStyle();

    final cashSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    cashSalesValueCell.value = TextCellValue(
        summaryModel.getCashSalesAsInt().toString().currencyFormatRp);
    cashSalesValueCell.cellStyle = CellStyle();
    currentRow++;

    // QRIS Sales
    final qrisSalesCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    qrisSalesCell.value = TextCellValue('Penjualan QRIS');
    qrisSalesCell.cellStyle = CellStyle();

    final qrisSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    qrisSalesValueCell.value = TextCellValue(
        summaryModel.getQrisSalesAsInt().toString().currencyFormatRp);
    qrisSalesValueCell.cellStyle = CellStyle();
    currentRow++;

    // QRIS Fee
    final qrisFeeCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
    qrisFeeCell.value = TextCellValue('Biaya QRIS');
    qrisFeeCell.cellStyle = CellStyle();

    final qrisFeeValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    qrisFeeValueCell.value = TextCellValue(summaryModel.qrisFee != null
        ? "- ${safeGetCurrencyFormat(summaryModel.qrisFee)}"
        : "- Rp 0,00");
    qrisFeeValueCell.cellStyle = CellStyle();
    currentRow++;

    // Beverage Sales
    final beverageSalesCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    beverageSalesCell.value = TextCellValue('Penjualan Minuman');
    beverageSalesCell.cellStyle = CellStyle();

    final beverageSalesValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    beverageSalesValueCell.value = TextCellValue(
        summaryModel.getBeverageSalesAsInt().toString().currencyFormatRp);
    beverageSalesValueCell.cellStyle = CellStyle();
    currentRow++;

    // Closing Balance
    final closingBalanceCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    closingBalanceCell.value = TextCellValue('Saldo Akhir');
    closingBalanceCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 12,
    );

    final closingBalanceValueCell =
        sheet.cell(CellIndex.indexByString("B$currentRow"));
    closingBalanceValueCell.value =
        TextCellValue(safeGetCurrencyFormat(summaryModel.closingBalance));
    closingBalanceValueCell.cellStyle = CellStyle(
      bold: true,
      fontSize: 12,
    );
    currentRow++;

    // Final Cash Closing if available
    if (summaryModel.finalCashClosing != null) {
      final finalCashCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
      finalCashCell.value = TextCellValue('Final Kas Akhir');
      finalCashCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 12,
      );

      final finalCashValueCell =
          sheet.cell(CellIndex.indexByString("B$currentRow"));
      finalCashValueCell.value =
          TextCellValue(safeGetCurrencyFormat(summaryModel.finalCashClosing));
      finalCashValueCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 12,
      );
      currentRow++;
    }

    currentRow++;

    // Beverage Breakdown
    if (summaryModel.beverageBreakdown != null) {
      sheet.merge(CellIndex.indexByString("A$currentRow"),
          CellIndex.indexByString("B$currentRow"));
      final beverageHeaderCell =
          sheet.cell(CellIndex.indexByString("A$currentRow"));
      beverageHeaderCell.value = TextCellValue('Rincian Penjualan Minuman');
      beverageHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow++;

      if (summaryModel.beverageBreakdown?.cash != null) {
        final cashBeverageCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        cashBeverageCell.value = TextCellValue(
            'Tunai (${summaryModel.beverageBreakdown!.cash!.getQuantityAsInt()} item)');

        final cashBeverageValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        cashBeverageValueCell.value = TextCellValue(safeGetCurrencyFormat(
            summaryModel.beverageBreakdown!.cash!.getAmountAsInt()));
        cashBeverageValueCell.cellStyle = CellStyle();
        currentRow++;
      }

      if (summaryModel.beverageBreakdown?.qris != null) {
        final qrisBeverageCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        qrisBeverageCell.value = TextCellValue(
            'QRIS (${summaryModel.beverageBreakdown!.qris!.getQuantityAsInt()} item)');

        final qrisBeverageValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        qrisBeverageValueCell.value = TextCellValue(safeGetCurrencyFormat(
            summaryModel.beverageBreakdown!.qris!.getAmountAsInt()));
        qrisBeverageValueCell.cellStyle = CellStyle();
        currentRow++;
      }

      if (summaryModel.beverageBreakdown?.total != null) {
        final totalBeverageCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        totalBeverageCell.value = TextCellValue(
            'Total (${summaryModel.beverageBreakdown!.total!.quantity} item)');
        totalBeverageCell.cellStyle = CellStyle(bold: true);

        final totalBeverageValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        totalBeverageValueCell.value = TextCellValue(safeGetCurrencyFormat(
            summaryModel.beverageBreakdown!.total!.amount));
        totalBeverageValueCell.cellStyle = CellStyle(
          bold: true,
        );
        currentRow++;
      }

      currentRow++;
    }

    // Payment Methods
    if (summaryModel.paymentMethods != null) {
      sheet.merge(CellIndex.indexByString("A$currentRow"),
          CellIndex.indexByString("B$currentRow"));
      final paymentHeaderCell =
          sheet.cell(CellIndex.indexByString("A$currentRow"));
      paymentHeaderCell.value = TextCellValue('Metode Pembayaran');
      paymentHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow++;

      if (summaryModel.paymentMethods?.cash != null) {
        // Cash Payment
        final cashPaymentCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        cashPaymentCell.value = TextCellValue(
            'Tunai (${summaryModel.paymentMethods!.cash!.count} transaksi)');

        final cashPaymentValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        cashPaymentValueCell.value = TextCellValue(summaryModel
            .paymentMethods!.cash!
            .getTotalAsInt()
            .toString()
            .currencyFormatRp);
        currentRow++;

        // Cash QRIS Fees
        final cashQrisFeeCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        cashQrisFeeCell.value = TextCellValue('Biaya QRIS Tunai');

        final cashQrisFeeValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        cashQrisFeeValueCell.value = TextCellValue(summaryModel
                    .paymentMethods!.cash!.qrisFees !=
                null
            ? "- ${safeGetCurrencyFormat(summaryModel.paymentMethods!.cash!.qrisFees)}"
            : "- Rp 0,00");
        cashQrisFeeValueCell.cellStyle = CellStyle();
        currentRow++;
      }

      if (summaryModel.paymentMethods?.qris != null) {
        // QRIS Payment
        final qrisPaymentCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        qrisPaymentCell.value = TextCellValue(
            'QRIS (${summaryModel.paymentMethods!.qris!.count} transaksi)');

        final qrisPaymentValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        qrisPaymentValueCell.value = TextCellValue(summaryModel
            .paymentMethods!.qris!
            .getTotalAsInt()
            .toString()
            .currencyFormatRp);
        currentRow++;

        // QRIS Fees
        final qrisFeeCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
        qrisFeeCell.value = TextCellValue('Biaya QRIS');

        final qrisFeeValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        qrisFeeValueCell.value = TextCellValue(summaryModel
                    .paymentMethods!.qris!.qrisFees !=
                null
            ? "- ${safeGetCurrencyFormat(summaryModel.paymentMethods!.qris!.qrisFees)}"
            : "- Rp 0,00");
        qrisFeeValueCell.cellStyle = CellStyle();
        currentRow++;
      }

      currentRow++;
    }

    // Daily Breakdown
    if (summaryModel.dailyBreakdown != null &&
        summaryModel.dailyBreakdown!.isNotEmpty) {
      sheet.merge(CellIndex.indexByString("A$currentRow"),
          CellIndex.indexByString("B$currentRow"));
      final dailyHeaderCell =
          sheet.cell(CellIndex.indexByString("A$currentRow"));
      dailyHeaderCell.value = TextCellValue('Rincian Harian');
      dailyHeaderCell.cellStyle = CellStyle(
        bold: true,
        fontSize: 14,
        horizontalAlign: HorizontalAlign.Left,
      );
      currentRow++;

      for (final day in summaryModel.dailyBreakdown!) {
        // Date
        final dateCell = sheet.cell(CellIndex.indexByString("A$currentRow"));
        dateCell.value = TextCellValue('Tanggal: ${day.date}');
        dateCell.cellStyle = CellStyle(bold: true);
        currentRow++;

        // Opening Balance
        final dayOpeningCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayOpeningCell.value = TextCellValue('Saldo Awal:');

        final dayOpeningValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayOpeningValueCell.value =
            TextCellValue(safeGetCurrencyFormat(day.openingBalance));
        currentRow++;

        // Expenses
        final dayExpensesCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayExpensesCell.value = TextCellValue('Pengeluaran:');

        final dayExpensesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayExpensesValueCell.value =
            TextCellValue("- ${safeGetCurrencyFormat(day.expenses)}");
        dayExpensesValueCell.cellStyle = CellStyle();
        currentRow++;

        // Cash Sales
        final dayCashSalesCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayCashSalesCell.value = TextCellValue('Penjualan Tunai:');

        final dayCashSalesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayCashSalesValueCell.value =
            TextCellValue(day.getCashSalesAsInt().toString().currencyFormatRp);
        dayCashSalesValueCell.cellStyle = CellStyle();
        currentRow++;

        // QRIS Sales
        final dayQrisSalesCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayQrisSalesCell.value = TextCellValue('Penjualan QRIS:');

        final dayQrisSalesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayQrisSalesValueCell.value =
            TextCellValue(day.getQrisSalesAsInt().toString().currencyFormatRp);
        dayQrisSalesValueCell.cellStyle = CellStyle();
        currentRow++;

        // QRIS Fee
        final dayQrisFeeCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayQrisFeeCell.value = TextCellValue('Biaya QRIS:');

        final dayQrisFeeValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayQrisFeeValueCell.value = TextCellValue(day.qrisFee != null
            ? "- ${safeGetCurrencyFormat(day.qrisFee)}"
            : "- Rp 0,00");
        dayQrisFeeValueCell.cellStyle = CellStyle();
        currentRow++;

        // Total Sales
        final dayTotalSalesCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayTotalSalesCell.value = TextCellValue('Total Penjualan:');

        final dayTotalSalesValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayTotalSalesValueCell.value =
            TextCellValue(safeGetCurrencyFormat(day.totalSales));
        currentRow++;

        // Closing Balance
        final dayClosingCell =
            sheet.cell(CellIndex.indexByString("A$currentRow"));
        dayClosingCell.value = TextCellValue('Saldo Akhir:');

        final dayClosingValueCell =
            sheet.cell(CellIndex.indexByString("B$currentRow"));
        dayClosingValueCell.value =
            TextCellValue(safeGetCurrencyFormat(day.closingBalance));
        currentRow++;

        // Final Cash Closing if available
        if (day.finalCashClosing != null) {
          final dayFinalCashCell =
              sheet.cell(CellIndex.indexByString("A$currentRow"));
          dayFinalCashCell.value = TextCellValue('Final Kas Akhir:');

          final dayFinalCashValueCell =
              sheet.cell(CellIndex.indexByString("B$currentRow"));
          dayFinalCashValueCell.value =
              TextCellValue(safeGetCurrencyFormat(day.finalCashClosing));
          currentRow++;
        }

        // Beverage Breakdown if available
        if (day.beverageBreakdown != null) {
          final beverageTitleCell =
              sheet.cell(CellIndex.indexByString("A$currentRow"));
          beverageTitleCell.value = TextCellValue('Rincian Minuman:');
          beverageTitleCell.cellStyle = CellStyle(bold: true);
          currentRow++;

          if (day.beverageBreakdown!.cash != null) {
            final dayBevCashCell =
                sheet.cell(CellIndex.indexByString("A$currentRow"));
            dayBevCashCell.value = TextCellValue(
                '- Tunai (${day.beverageBreakdown!.cash!.getQuantityAsInt()} item):');

            final dayBevCashValueCell =
                sheet.cell(CellIndex.indexByString("B$currentRow"));
            dayBevCashValueCell.value = TextCellValue(safeGetCurrencyFormat(
                day.beverageBreakdown!.cash!.getAmountAsInt()));
            dayBevCashValueCell.cellStyle = CellStyle();
            currentRow++;
          }

          if (day.beverageBreakdown!.qris != null) {
            final dayBevQrisCell =
                sheet.cell(CellIndex.indexByString("A$currentRow"));
            dayBevQrisCell.value = TextCellValue(
                '- QRIS (${day.beverageBreakdown!.qris!.getQuantityAsInt()} item):');

            final dayBevQrisValueCell =
                sheet.cell(CellIndex.indexByString("B$currentRow"));
            dayBevQrisValueCell.value = TextCellValue(safeGetCurrencyFormat(
                day.beverageBreakdown!.qris!.getAmountAsInt()));
            dayBevQrisValueCell.cellStyle = CellStyle();
            currentRow++;
          }

          if (day.beverageBreakdown!.total != null) {
            final dayBevTotalCell =
                sheet.cell(CellIndex.indexByString("A$currentRow"));
            dayBevTotalCell.value = TextCellValue(
                '- Total (${day.beverageBreakdown!.total!.quantity} item):');

            final dayBevTotalValueCell =
                sheet.cell(CellIndex.indexByString("B$currentRow"));
            dayBevTotalValueCell.value = TextCellValue(
                safeGetCurrencyFormat(day.beverageBreakdown!.total!.amount));
            dayBevTotalValueCell.cellStyle = CellStyle();
            currentRow++;
          }
        }

        currentRow++;
      }
    }

    // Footer with address
    currentRow++;
    sheet.merge(CellIndex.indexByString("A$currentRow"),
        CellIndex.indexByString("B$currentRow"));
    final addressTitleCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    addressTitleCell.value = TextCellValue('Alamat');
    addressTitleCell.cellStyle = CellStyle(bold: true);
    currentRow++;

    sheet.merge(CellIndex.indexByString("A$currentRow"),
        CellIndex.indexByString("B$currentRow"));
    final addressValueCell =
        sheet.cell(CellIndex.indexByString("A$currentRow"));
    addressValueCell.value = TextCellValue(outletAddress);

    // Set column widths
    sheet.setColumnWidth(0, 35.0);
    sheet.setColumnWidth(1, 25.0);

    return HelperExcelService.saveExcel(
      name:
          'seblak_sulthane_laporan_ringkasan_${DateTime.now().millisecondsSinceEpoch}.xlsx',
      excel: excel,
    );
  }
}
