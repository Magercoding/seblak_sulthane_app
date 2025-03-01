import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/utils/file_opener.dart';
import 'package:seblak_sulthane_app/core/utils/permession_handler.dart';
import 'package:seblak_sulthane_app/core/utils/revenue_invoice.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';

class SummaryReportWidget extends StatelessWidget {
  final SummaryData summary;
  final String title;
  final String searchDateFormatted;

  const SummaryReportWidget({
    Key? key,
    required this.summary,
    required this.title,
    required this.searchDateFormatted,
  }) : super(key: key);

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

        // Pass context to FileOpenerService
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

        // Only show error if it's not the "No APP found" error
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  searchDateFormatted,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  children: [
                    // Excel Export Button
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
                    // PDF Export Button
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
            const SpaceHeight(32.0),
            Expanded(
              child: _buildSummaryContent(),
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
              value:
                  'Rp ${formatCurrency(summary.totalServiceCharge.toDouble())}',
            ),
            const Divider(),
            SummaryItem(
              label: 'Total',
              value: 'Rp ${formatCurrency(summary.total.toDouble())}',
              isTotal: true,
            ),
          ],
        ),
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

  const SummaryItem({
    Key? key,
    required this.label,
    required this.value,
    this.isTotal = false,
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
            ),
          ),
        ],
      ),
    );
  }
}
