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
  String title = 'Summary Sales Report';
  DateTime fromDate = DateTime.now().subtract(const Duration(days: 30));
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
        '${fromDate.toFormattedDate2()} to ${toDate.toFormattedDate2()}';

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
                            prefix: const Text('From: '),
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
                            prefix: const Text('To: '),
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
                            label: 'Transaction Report',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 0;
                                title = 'Transaction Report';
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
                            label: 'Item Sales Report',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 1;
                                title = 'Item Sales Report';
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
                            label: 'Product Sales Chart',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 2;
                                title = 'Product Sales Chart';
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
                            label: 'Summary Sales Report',
                            onPressed: () {
                              setState(() {
                                selectedMenu = 3;
                                title = 'Summary Sales Report';
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
      _getTitleItemWidget('Tax', 100),
      _getTitleItemWidget('Disocunt', 100),
      _getTitleItemWidget('Service', 100),
      _getTitleItemWidget('Total Item', 100),
      _getTitleItemWidget('Payment Method', 130),
      _getTitleItemWidget('Cashier', 180),
      _getTitleItemWidget('Time', 180),
    ];
  }

  List<Widget> _getItemSalesPageWidget() {
    return [
      _getTitleItemWidget('ID', 80),
      _getTitleItemWidget('Order', 60),
      _getTitleItemWidget('Product', 160),
      _getTitleItemWidget('Qty', 60),
      _getTitleItemWidget('Price', 140),
      _getTitleItemWidget('Total Price', 140),
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
