import 'dart:developer';

import 'package:seblak_sulthane_app/core/components/spaces.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/utils/file_opener.dart';
import 'package:seblak_sulthane_app/core/utils/timezone_helper.dart';
import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/utils/permession_handler.dart';
import 'package:seblak_sulthane_app/core/utils/transaction_sales_invoice.dart';
import 'package:seblak_sulthane_app/data/models/response/order_response_model.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:permission_handler/permission_handler.dart';

class TransactionReportWidget extends StatelessWidget {
  final String title;
  final String searchDateFormatted;
  final List<ItemOrder> transactionReport;
  final List<Widget>? headerWidgets;
  final Function(ItemOrder)? onOrderSelected;

  const TransactionReportWidget({
    super.key,
    required this.transactionReport,
    required this.title,
    required this.searchDateFormatted,
    required this.headerWidgets,
    this.onOrderSelected,
  });

  Future<void> _handleExport(
      BuildContext context, bool isPdf, List<ItemOrder> data) async {
    final status = await PermessionHelper().checkPermission();
    if (status) {
      try {
        final file = isPdf
            ? await TransactionSalesInvoice.generatePdf(
                data, searchDateFormatted)
            : await TransactionSalesInvoice.generateExcel(
                data, searchDateFormatted);

        log("File yang dihasilkan: $file");
        await FileOpenerService.openFile(file, context);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'File ${isPdf ? 'PDF' : 'Excel'} berhasil dibuat!',
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        log("Kesalahan saat membuat file: $e");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Kesalahan saat membuat file ${isPdf ? 'PDF' : 'Excel'}: ${e.toString()}'),
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

  List<ItemOrder> _getSortedTransactions() {
    final sorted = List<ItemOrder>.from(transactionReport);
    sorted.sort((a, b) =>
        _getOrderDate(b).compareTo(_getOrderDate(a)));
    return sorted;
  }

  DateTime _getOrderDate(ItemOrder order) {
    return order.transactionTime ??
        order.createdAt ??
        DateTime.fromMillisecondsSinceEpoch(0);
  }

  @override
  Widget build(BuildContext context) {
    final sortedTransactions = _getSortedTransactions();

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
                      onTap: () =>
                          _handleExport(context, false, sortedTransactions),
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
                      onTap: () =>
                          _handleExport(context, true, sortedTransactions),
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
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: HorizontalDataTable(
                  leftHandSideColumnWidth: 50,
                  rightHandSideColumnWidth:
                      1110, // Lebar kolom diperbesar untuk metode pembayaran
                  isFixedHeader: true,
                  headerWidgets: headerWidgets,
                  leftSideItemBuilder: (context, index) {
                    return Container(
                      width: 40,
                      height: 52,
                      alignment: Alignment.centerLeft,
                      child: Center(
                          child: Text(sortedTransactions[index].id.toString())),
                    );
                  },
                  rightSideItemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (onOrderSelected != null) {
                          onOrderSelected!(sortedTransactions[index]);
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Text(
                              sortedTransactions[index].total!.currencyFormatRp,
                            )),
                          ),
                          Container(
                            width: 100,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Text(
                              sortedTransactions[index]
                                  .subTotal!
                                  .currencyFormatRp,
                            )),
                          ),
                          Container(
                            width: 100,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Text(
                              sortedTransactions[index].tax!.currencyFormatRp,
                            )),
                          ),
                          Container(
                            width: 100,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(
                                int.parse(sortedTransactions[index]
                                        .discountAmount!
                                        .replaceAll('.00', ''))
                                    .currencyFormatRp,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(
                                sortedTransactions[index]
                                    .serviceCharge!
                                    .currencyFormatRp,
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(sortedTransactions[index]
                                  .totalItem
                                  .toString()),
                            ),
                          ),
                          // Kolom Metode Pembayaran
                          Container(
                            width: 120,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(
                                sortedTransactions[index].paymentMethod ??
                                    'Tunai',
                              ),
                            ),
                          ),
                          Container(
                            width: 190,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(sortedTransactions[index].namaKasir!),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 52,
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Text(sortedTransactions[index]
                                  .transactionTime!
                                  .toFormattedDateWIB()),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: sortedTransactions.length,
                  rowSeparatorWidget: const Divider(
                    color: Colors.black38,
                    height: 1.0,
                    thickness: 0.0,
                  ),
                  leftHandSideColBackgroundColor: AppColors.white,
                  rightHandSideColBackgroundColor: AppColors.white,
                  itemExtent: 55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
