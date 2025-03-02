import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';

import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/status_table/status_table_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/pages/home_page.dart';
import 'package:seblak_sulthane_app/presentation/table/blocs/get_table/get_table_bloc.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_model.dart';
import 'package:seblak_sulthane_app/presentation/table/pages/payment_table_page.dart';

class CardTableWidget extends StatefulWidget {
  final TableModel table;
  const CardTableWidget({
    super.key,
    required this.table,
  });

  @override
  State<CardTableWidget> createState() => _CardTableWidgetState();
}

class _CardTableWidgetState extends State<CardTableWidget> {
  DraftOrderModel? data;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    if (widget.table.status != 'available') {
      data = await ProductLocalDatasource.instance
          .getDraftOrderById(widget.table.orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
            color: widget.table.status == 'available'
                ? AppColors.primary
                : AppColors.red,
            width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Table ${widget.table.tableNumber}',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.table.status == 'available'
                ? widget.table.status
                : "${widget.table.status} - ${DateTime.parse(widget.table.startTime).toFormattedTime()}",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Button.filled(
              color: widget.table.status == 'available'
                  ? AppColors.primary
                  : AppColors.red,
              onPressed: () async {
                if (widget.table.status == 'available') {
                  context.push(HomePage(
                    isTable: true,
                    table: widget.table,
                  ));
                } else {
                  context.read<CheckoutBloc>().add(
                        CheckoutEvent.loadDraftOrder(data!),
                      );
                  log("Data Draft Order: ${data!.toMap()}");
                  context.push(PaymentTablePage(
                    table: widget.table,
                    draftOrder: data!,
                  ));
                }
              },
              label: widget.table.status == 'available' ? 'Open' : 'Close')
        ],
      ),
    );
  }
}
