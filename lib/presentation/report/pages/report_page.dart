import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/components/custom_date_picker.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/utils/date_formatter.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_remote_datasource.dart';
import 'package:seblak_sulthane_app/presentation/report/blocs/item_sales_report/item_sales_report_bloc.dart';
import 'package:seblak_sulthane_app/presentation/report/blocs/product_sales/product_sales_bloc.dart';
import 'package:seblak_sulthane_app/presentation/report/blocs/summary/summary_bloc.dart';
import 'package:seblak_sulthane_app/presentation/report/blocs/transaction_report/transaction_report_bloc.dart';
import 'package:seblak_sulthane_app/presentation/report/widgets/item_sales_report_widget.dart';
import 'package:seblak_sulthane_app/presentation/report/widgets/product_sales_chart_widget.dart';
import 'package:seblak_sulthane_app/presentation/report/widgets/report_menu.dart';
import 'package:seblak_sulthane_app/presentation/report/widgets/report_title.dart';
import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/presentation/report/widgets/summary_report_widget.dart';
import 'package:seblak_sulthane_app/presentation/report/widgets/transaction_report_widget.dart';

import '../../../core/components/spaces.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int selectedMenu = 0;
  String title = 'Laporan Penjualan Ringkas';
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int? outletId;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchOutletId();
  }

  Future<void> _fetchOutletId() async {
    final authRemoteDatasource = AuthRemoteDatasource();
    final result = await authRemoteDatasource.getProfile();

    result.fold(
      (error) {
        setState(() {
          errorMessage = error;
          isLoading = false;
        });
      },
      (user) {
        setState(() {
          outletId = user.outletId;
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(child: Text(errorMessage)),
      );
    }

    if (outletId == null) {
      return const Scaffold(
        body: Center(child: Text('Outlet ID tidak ditemukan')),
      );
    }

    String searchDateFormatted =
        '${fromDate.toFormattedDate2()} sampai ${toDate.toFormattedDate2()}';

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ReportTitle(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomDatePicker(
                            prefix: const Text('Dari: '),
                            initialDate: fromDate,
                            onDateSelected: (selectedDate) {
                              setState(() {
                                fromDate = selectedDate;
                              });
                            },
                          ),
                        ),
                        const SpaceWidth(24.0),
                        Flexible(
                          child: CustomDatePicker(
                            prefix: const Text('Sampai: '),
                            initialDate: toDate,
                            onDateSelected: (selectedDate) {
                              setState(() {
                                toDate = selectedDate;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(
                        children: [
                          ReportMenu(
                            label: 'Laporan Transaksi',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 0;
                                title = 'Laporan Transaksi';
                              });
                              context.read<TransactionReportBloc>().add(
                                    TransactionReportEvent.getReport(
                                      startDate: DateFormatter.formatDateTime(
                                          fromDate),
                                      endDate:
                                          DateFormatter.formatDateTime(toDate),
                                      outletId: outletId!,
                                    ),
                                  );
                            },
                            isActive: selectedMenu == 0,
                          ),
                          ReportMenu(
                            label: 'Laporan Penjualan Item',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 1;
                                title = 'Laporan Penjualan Item';
                              });
                              context.read<ItemSalesReportBloc>().add(
                                    ItemSalesReportEvent.getItemSales(
                                      startDate: DateFormatter.formatDateTime(
                                          fromDate),
                                      endDate:
                                          DateFormatter.formatDateTime(toDate),
                                      outletId: outletId!,
                                    ),
                                  );
                            },
                            isActive: selectedMenu == 1,
                          ),
                          ReportMenu(
                            label: 'Grafik Penjualan Produk',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 2;
                                title = 'Grafik Penjualan Produk';
                              });
                              context.read<ProductSalesBloc>().add(
                                    ProductSalesEvent.getProductSales(
                                      DateFormatter.formatDateTime(fromDate),
                                      DateFormatter.formatDateTime(toDate),
                                      outletId!,
                                    ),
                                  );
                            },
                            isActive: selectedMenu == 2,
                          ),
                          ReportMenu(
                            label: 'Ringkasan Penjualan',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 3;
                                title = 'Ringkasan Penjualan';
                              });
                              context.read<SummaryBloc>().add(
                                    SummaryEvent.getSummary(
                                      DateFormatter.formatDateTime(fromDate),
                                      DateFormatter.formatDateTime(toDate),
                                      outletId!,
                                    ),
                                  );
                            },
                            isActive: selectedMenu == 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: selectedMenu == 0
                  ? BlocBuilder<TransactionReportBloc, TransactionReportState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (message) {
                            return Text(message);
                          },
                          loaded: (transactionReport) {
                            return TransactionReportWidget(
                              transactionReport: transactionReport,
                              title: title,
                              searchDateFormatted: searchDateFormatted,
                              headerWidgets: _getTitleReportPageWidget(),
                            );
                          },
                        );
                      },
                    )
                  : selectedMenu == 1
                      ? BlocBuilder<ItemSalesReportBloc, ItemSalesReportState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (message) {
                                return Text(message);
                              },
                              loaded: (itemSales) {
                                return ItemSalesReportWidget(
                                  itemSales: itemSales,
                                  title: title,
                                  searchDateFormatted: searchDateFormatted,
                                  headerWidgets: _getItemSalesPageWidget(),
                                );
                              },
                            );
                          },
                        )
                      : selectedMenu == 2
                          ? BlocBuilder<ProductSalesBloc, ProductSalesState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  error: (message) {
                                    return Text(message);
                                  },
                                  success: (productSales) {
                                    return ProductSalesChartWidgets(
                                      title: title,
                                      searchDateFormatted: searchDateFormatted,
                                      productSales: productSales,
                                    );
                                  },
                                );
                              },
                            )
                          : BlocBuilder<SummaryBloc, SummaryState>(
                              builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  error: (message) {
                                    return Text(message);
                                  },
                                  success: (summary) {
                                    return SummaryReportWidget(
                                      summary: summary,
                                      title: title,
                                      searchDateFormatted: searchDateFormatted,
                                    );
                                  },
                                );
                              },
                            )),
        ],
      ),
    );
  }

  List<Widget> _getTitleReportPageWidget() {
    return [
      _getTitleItemWidget('ID', 120),
      _getTitleItemWidget('Total', 100),
      _getTitleItemWidget('Sub Total', 100),
      _getTitleItemWidget('Pajak', 100),
      _getTitleItemWidget('Diskon', 100),
      _getTitleItemWidget('Layanan', 100),
      _getTitleItemWidget('Total Item', 100),
      _getTitleItemWidget('Metode Pembayaran', 130),
      _getTitleItemWidget('Kasir', 180),
      _getTitleItemWidget('Waktu', 180),
    ];
  }

  List<Widget> _getItemSalesPageWidget() {
    return [
      _getTitleItemWidget('ID', 80),
      _getTitleItemWidget('Pesanan', 60),
      _getTitleItemWidget('Produk', 160),
      _getTitleItemWidget('Kategori', 120),
      _getTitleItemWidget('Jml', 60),
      _getTitleItemWidget('Harga', 140),
      _getTitleItemWidget('Total Harga', 140),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.primary,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
