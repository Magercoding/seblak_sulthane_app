import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          Text(
            searchDateFormatted,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 32.0),
          Container(
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
            child: Column(
              children: [
                SummaryItem(
                  label: 'Total Revenue',
                  value:
                      'Rp ${formatCurrency(double.parse(summary.totalRevenue))}',
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
