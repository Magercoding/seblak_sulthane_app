// Update the CardTableWidget class:
// This code modifies the button logic to handle different status conditions

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:seblak_sulthane_app/core/components/components.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/date_time_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/pages/home_page.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_model.dart';
import 'package:seblak_sulthane_app/presentation/table/pages/close_table_confirmation_dialog.dart.dart';
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

  // Get the appropriate color based on table status
  Color getStatusColor() {
    switch (widget.table.status) {
      case 'available':
        return AppColors.primary;
      case 'closed':
        return Colors.orange;
      default: // 'occupied' or any other status
        return AppColors.red;
    }
  }

  // Get the appropriate button label based on table status
  String getButtonLabel() {
    switch (widget.table.status) {
      case 'available':
        return 'Open';
      case 'closed':
        return 'Close';
      default: // 'occupied' or any other status
        return 'Close';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(color: getStatusColor(), width: 2),
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
              color: getStatusColor(),
              onPressed: () async {
                // Handle button press based on table status
                if (widget.table.status == 'available') {
                  // Open the table
                  context.push(HomePage(
                    isTable: true,
                    table: widget.table,
                  ));
                } else if (widget.table.status == 'closed') {
                  // Show close confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => CloseTableConfirmationDialog(
                      table: widget.table,
                    ),
                  );
                } else {
                  // For occupied tables - proceed to payment
                  context.read<CheckoutBloc>().add(
                        CheckoutEvent.loadDraftOrder(data!),
                      );
                  log("Data Draft Order: ${data!.toMap()}");
                  context.push(PaymentTablePage(
                    table: widget.table,
                    draftOrder: data!,
                    isTable: true, // Add this parameter
                    orderType: 'dine_in',
                  ));
                }
              },
              label: getButtonLabel())
        ],
      ),
    );
  }
}
