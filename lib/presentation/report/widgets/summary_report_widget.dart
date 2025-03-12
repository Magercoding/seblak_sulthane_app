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
    Key? key,
    required this.summary,
    required this.title,
    required this.searchDateFormatted,
  }) : super(key: key);

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
                    'Printing ${isEndShift ? 'end shift' : 'summary report'}...'),
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
              '${isEndShift ? 'End shift' : 'Summary report'} printed successfully.');
        } else {
          _showPrintStatusDialog(context, false,
              'Failed to print ${isEndShift ? 'end shift' : 'summary report'}. Please check if the printer is connected and properly set up.');
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
              isSuccess ? 'Print Berhasil' : 'Print Gagal',
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
              '${isPdf ? 'PDF' : 'Excel'} file has been generated successfully!',
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
                  'Error with ${isPdf ? 'PDF' : 'Excel'} file: ${e.toString()}'),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
            const SpaceHeight(32.0),
            Expanded(
              child: _buildSummaryContent(),
            ),
            const SpaceHeight(16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _handlePrint(
                        context, false), // false for summary report
                    icon: const Icon(Icons.print, color: Colors.white),
                    label: const Text(
                      "Print Summary",
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
                      "Print End Shift",
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
          ],
        ),
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
            // Financial Summary Section
            const Text(
              'Financial Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Revenue Section
            SummaryItem(
              label: 'Total Revenue',
              value: 'Rp ${formatCurrency(double.parse(summary.totalRevenue))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Total Subtotal',
              value:
                  'Rp ${formatCurrency(double.parse(summary.totalSubtotal))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Total Tax',
              value: 'Rp ${formatCurrency(double.parse(summary.totalTax))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Total Discount',
              value:
                  'Rp ${formatCurrency(double.parse(summary.totalDiscount))}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Service Charge',
              value: summary.totalServiceCharge is num
                  ? 'Rp ${formatCurrency((summary.totalServiceCharge as num).toDouble())}'
                  : summary.totalServiceCharge is String
                      ? 'Rp ${formatCurrency(double.parse(summary.totalServiceCharge as String))}'
                      : 'Rp 0.00',
            ),
            const Divider(),

            // Daily Cash Section
            const SizedBox(height: 20),
            const Text(
              'Daily Cash Flow',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            SummaryItem(
              label: 'Opening Balance',
              value: summary.openingBalance != null
                  ? 'Rp ${formatCurrency(summary.openingBalance!.toDouble())}'
                  : 'Rp 0.00',
            ),
            const Divider(),
            SummaryItem(
              label: 'Expenses',
              value: summary.expenses != null
                  ? 'Rp ${formatCurrency(summary.expenses!.toDouble())}'
                  : 'Rp 0.00',
              textColor: Colors.red,
            ),
            const Divider(),
            SummaryItem(
              label: 'Cash Sales',
              value:
                  'Rp ${formatCurrency(summary.getCashSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),
            const Divider(),
            SummaryItem(
              label: 'QRIS Sales',
              value:
                  'Rp ${formatCurrency(summary.getQrisSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),
            const Divider(),
            SummaryItem(
              label: 'Beverage Sales',
              value:
                  'Rp ${formatCurrency(summary.getBeverageSalesAsInt().toDouble())}',
              textColor: Colors.green,
            ),
            const Divider(),
            SummaryItem(
              label: 'Closing Balance',
              value: summary.closingBalance != null
                  ? 'Rp ${formatCurrency(summary.closingBalance!.toDouble())}'
                  : 'Rp 0.00',
              isTotal: true,
            ),

            // Payment Methods Section
            if (summary.paymentMethods != null) ...[
              const SizedBox(height: 20),
              const Text(
                'Payment Methods',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (summary.paymentMethods?.cash != null)
                SummaryItem(
                  label:
                      'Cash (${summary.paymentMethods!.cash!.count} transactions)',
                  value:
                      'Rp ${formatCurrency(summary.paymentMethods!.cash!.getTotalAsInt().toDouble())}',
                ),
              if (summary.paymentMethods?.cash != null &&
                  summary.paymentMethods?.qris != null)
                const Divider(),
              if (summary.paymentMethods?.qris != null)
                SummaryItem(
                  label:
                      'QRIS (${summary.paymentMethods!.qris!.count} transactions)',
                  value:
                      'Rp ${formatCurrency(summary.paymentMethods!.qris!.getTotalAsInt().toDouble())}',
                ),
            ],

            // Daily Breakdown Section
            if (summary.dailyBreakdown != null &&
                summary.dailyBreakdown!.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Daily Breakdown',
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
            'Date: ${day.date}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Opening:'),
              Text(
                day.openingBalance != null
                    ? 'Rp ${formatCurrency(day.openingBalance!.toDouble())}'
                    : 'Rp 0.00',
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Expenses:'),
              Text(
                day.expenses != null
                    ? 'Rp ${formatCurrency(day.expenses!.toDouble())}'
                    : 'Rp 0.00',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Cash Sales:'),
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
              const Text('QRIS Sales:'),
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
              const Text('Total Sales:'),
              Text(
                day.totalSales != null
                    ? 'Rp ${formatCurrency(day.totalSales!.toDouble())}'
                    : 'Rp 0.00',
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Closing Balance:'),
              Text(
                day.closingBalance != null
                    ? 'Rp ${formatCurrency(day.closingBalance!.toDouble())}'
                    : 'Rp 0.00',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
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
    Key? key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.textColor,
  }) : super(key: key);

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
