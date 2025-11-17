import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/utils/file_opener.dart';
import 'package:seblak_sulthane_app/core/utils/permession_handler.dart';
import 'package:seblak_sulthane_app/core/utils/revenue_invoice.dart';
import 'package:seblak_sulthane_app/data/dataoutputs/print_dataoutputs.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';

class SummaryReportWidget extends StatelessWidget {
  final EnhancedSummaryData summary;
  final String title;
  final String searchDateFormatted;

  const SummaryReportWidget({
    super.key,
    required this.summary,
    required this.title,
    required this.searchDateFormatted,
  });

  Future<void> _handlePrint(BuildContext context, bool isEndShift) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                    'Mencetak ${isEndShift ? 'akhir shift' : 'laporan ringkasan'}...'),
              ],
            ),
          );
        },
      );

      // Get receipt size from local storage
      final sizeReceipt = await AuthLocalDataSource().getSizeReceipt();

      // Default to size 80 if parsing fails
      int receiptSize;
      try {
        receiptSize = int.parse(sizeReceipt);
      } catch (e) {
        log('Error parsing receipt size: $sizeReceipt');
        receiptSize = 80; // Default value
      }

      // Generate bytes based on report type
      final List<int> printBytes = isEndShift
          ? await PrintDataoutputs.instance.printEndShift(
              summary,
              searchDateFormatted,
              receiptSize,
            )
          : await PrintDataoutputs.instance.printSummaryReport(
              summary,
              searchDateFormatted,
              receiptSize,
            );

      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Print the report
      final result = await PrintBluetoothThermal.writeBytes(printBytes);

      // Show result dialog
      if (context.mounted) {
        if (result) {
          _showPrintStatusDialog(context, true,
              '${isEndShift ? 'Laporan akhir shift' : 'Laporan ringkasan'} berhasil dicetak.');
        } else {
          _showPrintStatusDialog(context, false,
              'Gagal mencetak ${isEndShift ? 'laporan akhir shift' : 'laporan ringkasan'}. Periksa apakah printer terhubung dan diatur dengan benar.');
        }
      }
    } catch (e) {
      log("Error printing report: $e");

      // Close loading dialog if still showing
      if (context.mounted) {
        Navigator.pop(context);
        _showPrintStatusDialog(context, false, 'Error: ${e.toString()}');
      }
    }
  }

  // Helper method to show print status dialog
  void _showPrintStatusDialog(
      BuildContext context, bool isSuccess, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: isSuccess
                  ? Icon(Icons.check_circle, color: Colors.green, size: 60)
                  : Icon(Icons.error_outline, color: Colors.red, size: 60),
            ),
            const SizedBox(height: 16.0),
            Text(
              isSuccess ? 'Cetak Berhasil' : 'Cetak Gagal',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleExport(
    BuildContext context,
    bool isPdf,
  ) async {
    final status = await PermessionHelper().checkPermission();
    if (status) {
      try {
        final file = isPdf
            ? await RevenueInvoice.generatePdf(summary, searchDateFormatted)
            : await RevenueInvoice.generateExcel(summary, searchDateFormatted);

        log("Generated file: $file");

        await FileOpenerService.openFile(file, context);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'File ${isPdf ? 'PDF' : 'Excel'} berhasil dibuat!',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        log("Error handling file: $e");
        if (!context.mounted) return;

        if (!e.toString().contains('No APP found to open this file')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Error dengan file ${isPdf ? 'PDF' : 'Excel'}: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Izin Dibutuhkan'),
          content: const Text(
            'Aplikasi membutuhkan izin untuk menyimpan dan mengakses file. Harap aktifkan izin di pengaturan.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: const Text('Pengaturan'),
            ),
          ],
        ),
      );
    }
  }

  // Helper method to safely parse any numeric value
  double parseNumericValue(dynamic value) {
    if (value == null) return 0.0;

    if (value is double) return value;
    if (value is int) return value.toDouble();

    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        return 0.0;
      }
    }

    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          const SpaceHeight(24.0),
          Center(
            child: Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  searchDateFormatted,
                  style: const TextStyle(fontSize: 16.0),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _handleExport(context, false),
                      child: const Row(
                        children: [
                          Text(
                            "Excel",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Icon(
                            Icons.download_outlined,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => _handleExport(context, true),
                      child: const Row(
                        children: [
                          Text(
                            "PDF",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Icon(
                            Icons.download_outlined,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SpaceHeight(16.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: _buildSummaryContent(),
            ),
          ),
          const SpaceHeight(16.0),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handlePrint(
                        context, false), // false for summary report
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: const Text(
                      "Cetak Ringkasan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        _handlePrint(context, true), // true for end shift
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: const Text(
                      "Cetak Akhir Shift",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryContent() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Add Summary Overview Section
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Add Total Orders
            SummaryItem(
              label: 'Total Pesanan',
              value: '${summary.totalOrders ?? 0}',
            ),
            const Divider(),

            // Add Total Items
            SummaryItem(
              label: 'Total Item Terjual',
              value: summary.totalItems ?? "0",
            ),
            const Divider(),

            // Financial Summary Section
            const SizedBox(height: 20),
            const Text(
              'Ringkasan Keuangan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Revenue Section
            SummaryItem(
              label: 'Total Pendapatan',
              value:
                  'Rp ${formatCurrency(parseNumericValue(summary.totalRevenue))}',
            ),
            const Divider(),

            SummaryItem(
              label: 'Total Subtotal',
              value:
                  'Rp ${formatCurrency(parseNumericValue(summary.totalSubtotal))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Total Pajak',
              value:
                  'Rp ${formatCurrency(parseNumericValue(summary.totalTax))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Total Diskon',
              value:
                  'Rp ${formatCurrency(parseNumericValue(summary.totalDiscount))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Biaya Layanan',
              value:
                  'Rp ${formatCurrency(parseNumericValue(summary.totalServiceCharge))}',
            ),
            const Divider(),

            // Rincian Penjualan Makanan (dipindahkan ke atas)
            if (summary.foodBreakdown != null) ...[
              const SizedBox(height: 20),
              _buildSalesBreakdownSection(
                title: 'Rincian Penjualan Makanan',
                breakdown: summary.foodBreakdown!,
              ),
            ],

            // Rincian Penjualan Minuman (setelah Rincian Makanan)
            if (summary.beverageBreakdown != null) ...[
              const SizedBox(height: 20),
              _buildSalesBreakdownSection(
                title: 'Rincian Penjualan Minuman',
                breakdown: summary.beverageBreakdown!,
              ),
            ],

            // Daily Cash Section (dipindahkan setelah rincian)
            const SizedBox(height: 20),
            const Text(
              'Arus Kas Harian',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            SummaryItem(
              label: 'Saldo Awal',
              value: summary.openingBalance != null
                  ? 'Rp ${formatCurrency(summary.openingBalance!)}'
                  : 'Rp 0.00',
            ),
            const Divider(),
            SummaryItem(
              label: 'Pengeluaran',
              value: summary.expenses != null
                  ? 'Rp ${formatCurrency(summary.expenses!)}'
                  : 'Rp 0.00',
              textColor: Colors.red,
            ),
            const Divider(),
            SummaryItem(
              label: 'Penjualan Tunai',
              value:
                  'Rp ${formatCurrency(summary.getCashSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),
            const Divider(),
            SummaryItem(
              label: 'Penjualan QRIS',
              value:
                  'Rp ${formatCurrency(summary.getQrisSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),
            const Divider(),
            SummaryItem(
              label: 'Biaya QRIS',
              value: summary.qrisFee != null
                  ? 'Rp ${formatCurrency(parseNumericValue(summary.qrisFee))}'
                  : 'Rp 0.00',
              textColor: Colors.red,
            ),
            const Divider(),
            SummaryItem(
              label: 'Penjualan Makanan',
              value:
                  'Rp ${formatCurrency(summary.getFoodSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),
            const Divider(),
            SummaryItem(
              label: 'Penjualan Minuman',
              value:
                  'Rp ${formatCurrency(summary.getBeverageSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),

            if (_hasOverallBreakdown(summary)) ...[
              const SizedBox(height: 20),
              const Text(
                'Rincian Keseluruhan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SummaryItem(
                label: 'Tunai',
                value:
                    'Rp ${formatCurrency(summary.getCashSalesAsInt().toDouble())}',
                textColor: Colors.green,
              ),
              const Divider(),
              SummaryItem(
                label: 'QRIS',
                value:
                    'Rp ${formatCurrency(summary.getQrisSalesAsInt().toDouble())}',
                textColor: Colors.green,
              ),
              const Divider(),
              SummaryItem(
                label: 'Total Penjualan',
                value:
                    'Rp ${formatCurrency((summary.getCashSalesAsInt() + summary.getQrisSalesAsInt()).toDouble())}',
                textColor: Colors.green,
                isTotal: true,
              ),
              const Divider(),
              SummaryItem(
                label: 'Saldo Akhir',
                value: summary.closingBalance != null
                    ? 'Rp ${formatCurrency(summary.closingBalance!)}'
                    : 'Rp 0.00',
                isTotal: true,
              ),
              if (summary.finalCashClosing != null) ...[
                SummaryItem(
                  label: 'Final Kas Akhir',
                  value:
                      'Rp ${formatCurrency(summary.getFinalCashClosingAsInt().toDouble())}',
                  isTotal: true,
                ),
              ],
            ],

            // Payment Methods Section
            if (summary.paymentMethods != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (summary.paymentMethods?.cash != null) ...[
                SummaryItem(
                  label:
                      'Tunai (${summary.paymentMethods!.cash!.count} transaksi)',
                  value:
                      'Rp ${formatCurrency(summary.paymentMethods!.cash!.getTotalAsInt().toDouble())}',
                ),
                // Add Cash QRIS Fees (usually 0)
                SummaryItem(
                  label: 'Biaya QRIS Tunai',
                  value: summary.paymentMethods!.cash!.qrisFees != null
                      ? 'Rp ${formatCurrency(parseNumericValue(summary.paymentMethods!.cash!.qrisFees))}'
                      : 'Rp 0.00',
                  textColor: Colors.red,
                ),
              ] else ...[
                // Show no cash transactions if cash is null
                const SummaryItem(
                  label: 'Tunai (0 transaksi)',
                  value: 'Rp 0.00',
                ),
              ],
              const Divider(),
              if (summary.paymentMethods?.qris != null) ...[
                SummaryItem(
                  label:
                      'QRIS (${summary.paymentMethods!.qris!.count} transaksi)',
                  value:
                      'Rp ${formatCurrency(summary.paymentMethods!.qris!.getTotalAsInt().toDouble())}',
                ),
                // Add QRIS Fees
                SummaryItem(
                  label: 'Biaya QRIS',
                  value: summary.paymentMethods!.qris!.qrisFees != null
                      ? 'Rp ${formatCurrency(parseNumericValue(summary.paymentMethods!.qris!.qrisFees))}'
                      : 'Rp 0.00',
                  textColor: Colors.red,
                ),
              ] else ...[
                // Show no QRIS transactions if qris is null
                const SummaryItem(
                  label: 'QRIS (0 transaksi)',
                  value: 'Rp 0.00',
                ),
              ],
            ] else ...[
              // Show a message when there are no payment methods at all
              const SizedBox(height: 20),
              const Text(
                'Metode Pembayaran',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const SummaryItem(
                label: 'Data metode pembayaran tidak tersedia',
                value: '',
              ),
            ],

            // Daily Breakdown Section
            if (summary.dailyBreakdown != null &&
                summary.dailyBreakdown!.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Rincian Harian',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              for (var i = 0; i < summary.dailyBreakdown!.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _buildDailyBreakdownItem(summary.dailyBreakdown![i]),
                if (i < summary.dailyBreakdown!.length - 1) const Divider(),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSalesBreakdownSection({
    required String title,
    required BeverageBreakdown breakdown,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (breakdown.cash != null) ...[
          SummaryItem(
            label: 'Tunai (${breakdown.cash!.getQuantityAsInt()} item)',
            value:
                'Rp ${formatCurrency(breakdown.cash!.getAmountAsInt().toDouble())}',
            textColor: Colors.green,
          ),
        ],
        if (breakdown.qris != null) ...[
          SummaryItem(
            label: 'QRIS (${breakdown.qris!.getQuantityAsInt()} item)',
            value:
                'Rp ${formatCurrency(breakdown.qris!.getAmountAsInt().toDouble())}',
            textColor: Colors.green,
          ),
        ],
        if (breakdown.total != null) ...[
          SummaryItem(
            label: 'Total (${breakdown.total!.quantity} item)',
            value: 'Rp ${formatCurrency(breakdown.total!.amount.toDouble())}',
            textColor: Colors.green,
            isTotal: true,
          ),
        ],
      ],
    );
  }

  bool _hasOverallBreakdown(EnhancedSummaryData summary) {
    return summary.getCashSalesAsInt() > 0 ||
        summary.getQrisSalesAsInt() > 0 ||
        summary.closingBalance != null ||
        summary.finalCashClosing != null;
  }

  Widget _buildDailyBreakdownItem(DailyBreakdown day) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tanggal: ${day.date}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),

          // Rincian Makanan (dipindahkan ke atas)
          if (day.foodBreakdown != null) ...[
            const SizedBox(height: 8),
            const Text(
              'Rincian Makanan:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (day.foodBreakdown!.cash != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '- Tunai (${day.foodBreakdown!.cash!.getQuantityAsInt()} item):'),
                  Text(
                    'Rp ${formatCurrency(day.foodBreakdown!.cash!.getAmountAsInt().toDouble())}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
            if (day.foodBreakdown!.qris != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '- QRIS (${day.foodBreakdown!.qris!.getQuantityAsInt()} item):'),
                  Text(
                    'Rp ${formatCurrency(day.foodBreakdown!.qris!.getAmountAsInt().toDouble())}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
            if (day.foodBreakdown!.total != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('- Total (${day.foodBreakdown!.total!.quantity} item):'),
                  Text(
                    'Rp ${formatCurrency(day.foodBreakdown!.total!.amount.toDouble())}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],

          // Rincian Minuman (setelah Rincian Makanan)
          if (day.beverageBreakdown != null) ...[
            const SizedBox(height: 8),
            const Text(
              'Rincian Minuman:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (day.beverageBreakdown!.cash != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '- Tunai (${day.beverageBreakdown!.cash!.getQuantityAsInt()} item):'),
                  Text(
                    'Rp ${formatCurrency(day.beverageBreakdown!.cash!.getAmountAsInt().toDouble())}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
            if (day.beverageBreakdown!.qris != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '- QRIS (${day.beverageBreakdown!.qris!.getQuantityAsInt()} item):'),
                  Text(
                    'Rp ${formatCurrency(day.beverageBreakdown!.qris!.getAmountAsInt().toDouble())}',
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
            if (day.beverageBreakdown!.total != null) ...[
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '- Total (${day.beverageBreakdown!.total!.quantity} item):'),
                  Text(
                    'Rp ${formatCurrency(day.beverageBreakdown!.total!.amount.toDouble())}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],

          // Saldo Awal (dipindahkan setelah rincian)
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo Awal:'),
              Text(
                day.openingBalance != null
                    ? 'Rp ${formatCurrency(day.openingBalance!)}'
                    : 'Rp 0.00',
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Pengeluaran:'),
              Text(
                day.expenses != null
                    ? 'Rp ${formatCurrency(day.expenses!)}'
                    : 'Rp 0.00',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Penjualan Tunai:'),
              Text(
                'Rp ${formatCurrency(day.getCashSalesAsInt().toDouble())}',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Penjualan QRIS:'),
              Text(
                'Rp ${formatCurrency(day.getQrisSalesAsInt().toDouble())}',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Penjualan:'),
              Text(
                day.totalSales != null
                    ? 'Rp ${formatCurrency(parseNumericValue(day.totalSales))}'
                    : 'Rp 0.00',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Biaya QRIS:'),
              Text(
                day.qrisFee != null
                    ? 'Rp ${formatCurrency(parseNumericValue(day.qrisFee))}'
                    : 'Rp 0.00',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Saldo Akhir:'),
              Text(
                day.closingBalance != null
                    ? 'Rp ${formatCurrency(day.closingBalance!)}'
                    : 'Rp 0.00',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          // Add Final Cash Closing
          if (day.finalCashClosing != null) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Final Kas Akhir:'),
                Text(
                  'Rp ${formatCurrency(day.getFinalCashClosingAsInt().toDouble())}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String formatCurrency(double value) {
    return value.toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

class SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final Color? textColor;

  const SummaryItem({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
