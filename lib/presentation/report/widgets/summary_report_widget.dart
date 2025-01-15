// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:seblak_sulthane_app/core/components/dashed_line.dart';
import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/file_opener.dart';
import 'package:seblak_sulthane_app/core/utils/helper_pdf_service.dart';
import 'package:seblak_sulthane_app/core/utils/permession_handler.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/revenue_invoice.dart';

class SummaryReportWidget extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final SummaryModel summary;
  const SummaryReportWidget({
    super.key,
    required this.title,
    required this.searchDateFormatted,
    required this.summary,
  });

  Future<void> _handleExport(BuildContext context, bool isPdf) async {
    final status = await PermessionHelper().checkPermission();
    if (status) {
      try {
        final file = isPdf
            ? await RevenueInvoice.generatePdf(summary, searchDateFormatted)
            : await RevenueInvoice.generateExcel(summary, searchDateFormatted);

        log("Generated file: $file");
        await FileOpenerService.openFile(file, context);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${isPdf ? 'PDF' : 'Excel'} file has been generated successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        log("Error generating file: $e");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Error generating ${isPdf ? 'PDF' : 'Excel'} file: ${e.toString()}'),
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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceHeight(24.0),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 16.0),
              ),
            ),
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
            ),
            const SpaceHeight(16.0),
            Text(
              'REVENUE : ${int.parse(summary.totalRevenue!).currencyFormatRp}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SpaceHeight(8.0),
            const DashedLine(),
            const DashedLine(),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text(
                  int.parse(summary.totalSubtotal!).currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Discount'),
                Text(
                  "- ${int.parse(summary.totalDiscount!.replaceAll('.00', '')).currencyFormatRp}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tax'),
                Text(
                  "- ${int.parse(summary.totalTax!).currencyFormatRp}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Service Charge'),
                Text(
                  int.parse(summary.totalServiceCharge!).currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SpaceHeight(8.0),
            const DashedLine(),
            const DashedLine(),
            const SpaceHeight(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TOTAL'),
                Text(
                  summary.total!.currencyFormatRp,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
