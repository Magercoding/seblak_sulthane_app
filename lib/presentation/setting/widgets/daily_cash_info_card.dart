import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/data/models/response/daily_cash_model.dart';

class DailyCashInfoCard extends StatelessWidget {
  final DailyCashModel dailyCash;

  const DailyCashInfoCard({
    super.key,
    required this.dailyCash,
  });

  // Helper method to format the cash sales value safely
  String _formatCashSales() {
    if (dailyCash.cashSales == null) {
      return 'Rp 0';
    }

    if (dailyCash.cashSales is int) {
      return (dailyCash.cashSales as int).currencyFormatRp;
    }

    if (dailyCash.cashSales is String) {
      final value = int.tryParse(dailyCash.cashSales as String) ?? 0;
      return value.currencyFormatRp;
    }

    return 'Rp 0';
  }

  // Helper method to format QRIS sales value safely
  String _formatQrisSales() {
    final qrisSales = dailyCash.getQrisSalesAsInt();
    if (qrisSales == null || qrisSales == 0) {
      return 'Rp 0';
    }
    return qrisSales.currencyFormatRp;
  }

  // Helper method to format final cash closing value safely
  String _formatFinalCashClosing() {
    final finalCashClosing = dailyCash.getFinalCashClosingAsInt();
    if (finalCashClosing == null) {
      return 'Belum dihitung';
    }
    return finalCashClosing.currencyFormatRp;
  }

  // Helper method to format effective expenses
  String _formatEffectiveExpenses() {
    if (dailyCash.effectiveExpenses == null) {
      // Calculate if not provided: opening_balance + expenses
      final opening = dailyCash.openingBalance ?? 0;
      final expenses = dailyCash.expenses ?? 0;
      return (opening + expenses).currencyFormatRp;
    }
    return dailyCash.effectiveExpenses!.currencyFormatRp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.card, width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Kas Harian',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SpaceHeight(16),
          _buildInfoRow(
            'Saldo Awal:',
            dailyCash.openingBalance?.currencyFormatRp ?? 'Belum diatur',
          ),
          const SpaceHeight(8),
          _buildInfoRow(
            'Pengeluaran:',
            dailyCash.expenses?.currencyFormatRp ?? 'Rp 0',
            textColor: Colors.red,
          ),
          const SpaceHeight(8),
          _buildInfoRow(
            'Penjualan Tunai:',
            _formatCashSales(),
            textColor: Colors.green,
          ),
          const SpaceHeight(8),
          _buildInfoRow(
            'Penjualan QRIS:',
            _formatQrisSales(),
            textColor: Colors.blue,
          ),
          const SpaceHeight(8),
          _buildInfoRow(
            'Total Pengeluaran Efektif:',
            _formatEffectiveExpenses(),
            textColor: Colors.orange,
          ),
          const SpaceHeight(8),
          const Divider(),
          const SpaceHeight(8),
          _buildInfoRow(
            'Saldo Akhir:',
            dailyCash.closingBalance?.currencyFormatRp ?? 'Belum dihitung',
            isBold: true,
            fontSize: 18,
          ),
          const SpaceHeight(8),
          _buildInfoRow(
            'Final Cash Closing:',
            _formatFinalCashClosing(),
            textColor: Colors.green,
            isBold: true,
            fontSize: 16,
          ),
          if (dailyCash.expensesNote != null &&
              dailyCash.expensesNote!.isNotEmpty) ...[
            const SpaceHeight(24),
            Text(
              'Detail Pengeluaran:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SpaceHeight(8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                dailyCash.expensesNote!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color? textColor,
    bool isBold = false,
    double fontSize = 16,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
