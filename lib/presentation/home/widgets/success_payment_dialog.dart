import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/core/constants/colors.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/data/dataoutputs/print_dataoutputs.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../table/blocs/get_table/get_table_bloc.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../bloc/order/order_bloc.dart';

class SuccessPaymentDialog extends StatefulWidget {
  const SuccessPaymentDialog({
    super.key,
    required this.data,
    required this.totalQty,
    required this.totalPrice,
    required this.totalTax,
    required this.totalDiscount,
    required this.subTotal,
    required this.normalPrice,
    required this.totalService,
    required this.draftName,
    required this.orderType, // Added required orderType parameter
  });
  final List<ProductQuantity> data;
  final int totalQty;
  final int totalPrice;
  final int totalTax;
  final int totalDiscount;
  final int subTotal;
  final int normalPrice;
  final int totalService;
  final String draftName;
  final String orderType; // Order type field

  @override
  State<SuccessPaymentDialog> createState() => _SuccessPaymentDialogState();
}

class _SuccessPaymentDialogState extends State<SuccessPaymentDialog> {
  bool _isPrinting = false;
  String _orderTypeDisplay = ''; // To store the human-readable order type

  @override
  void initState() {
    super.initState();
    _orderTypeDisplay =
        widget.orderType == 'take_away' ? 'Take Away' : 'Dine In';

    final orderState = context.read<OrderBloc>().state;
    orderState.maybeWhen(loaded: (model, orderId) {
      log("OrderBloc state - paymentMethod: ${model.paymentMethod}, paymentAmount: ${model.paymentAmount}");
    }, orElse: () {
      log("OrderBloc state is not loaded");
    });
  }

  void _showPrintStatusDialog(bool isSuccess, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: isSuccess
                  ? Assets.icons.success.svg()
                  : Icon(Icons.error_outline, color: Colors.red, size: 60),
            ),
            const SpaceHeight(16.0),
            Text(
              isSuccess ? 'Print Berhasil' : 'Print Gagal',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SpaceHeight(8.0),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SpaceHeight(20.0),
            Button.filled(
              onPressed: () {
                Navigator.pop(context);
              },
              label: 'OK',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Assets.icons.success.svg()),
            const SpaceHeight(16.0),
            const Center(
              child: Text(
                'Pembayaran telah sukses dilakukan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SpaceHeight(20.0),
            // Display Order Type if it's defined
            if (widget.orderType.isNotEmpty) ...[
              const Text('TIPE PESANAN'),
              const SpaceHeight(5.0),
              Row(
                children: [
                  Text(
                    _orderTypeDisplay,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceWidth(8.0),
                  // Show a colored indicator based on order type
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: widget.orderType == 'take_away'
                          ? AppColors.primary.withOpacity(0.2)
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _orderTypeDisplay,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.orderType == 'take_away'
                            ? AppColors.primary
                            : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SpaceHeight(10.0),
              const Divider(),
              const SpaceHeight(8.0),
            ],
            const Text('METODE BAYAR'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentMethod = state.maybeWhen(
                  orElse: () => 'Cash', // Default to Cash
                  loaded: (model, orderId) => model.paymentMethod.isNotEmpty
                      ? model.paymentMethod
                      : 'Cash', // Use model data or default
                );
                return Text(
                  paymentMethod,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('TOTAL TAGIHAN'),
            const SpaceHeight(5.0),
            Text(
              widget.totalPrice.currencyFormatRp,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('NOMINAL BAYAR'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                // Get payment amount, falling back to total price if needed
                final paymentAmount = state.maybeWhen(
                  orElse: () => widget.totalPrice,
                  loaded: (model, orderId) => model.paymentAmount > 0
                      ? model.paymentAmount
                      : widget.totalPrice,
                );

                // Log for debugging
                log("Displaying payment amount: $paymentAmount");

                return Text(
                  paymentAmount.ceil().currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentMethod = state.maybeWhen(
                  orElse: () => 'Cash',
                  loaded: (model, orderId) => model.paymentMethod.isNotEmpty
                      ? model.paymentMethod
                      : 'Cash',
                );

                // Only show kembalian section for Cash payments
                if (paymentMethod == 'Cash') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(),
                      const SpaceHeight(8.0),
                      const Text('KEMBALIAN'),
                      const SpaceHeight(5.0),
                      BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          // Get payment amount with fallback
                          final paymentAmount = state.maybeWhen(
                            orElse: () => widget.totalPrice,
                            loaded: (model, orderId) => model.paymentAmount > 0
                                ? model.paymentAmount
                                : widget.totalPrice,
                          );

                          // Calculate change - ensure it's not negative
                          final diff = paymentAmount - widget.totalPrice;
                          final change = diff > 0 ? diff : 0;

                          log("Change calculation - payment: $paymentAmount, total: ${widget.totalPrice}, diff: $diff, change: $change");

                          return Text(
                            change.ceil().currencyFormatRp,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  // For non-cash payments like QRIS, don't show kembalian
                  return const SizedBox.shrink();
                }
              },
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('WAKTU PEMBAYARAN'),
            const SpaceHeight(5.0),
            Text(
              DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.now()),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(20.0),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      context
                          .read<CheckoutBloc>()
                          .add(const CheckoutEvent.started());
                      context
                          .read<GetTableBloc>()
                          .add(const GetTableEvent.getTables());
                      context.popToRoot();
                    },
                    label: 'Kembali',
                  ),
                ),
                const SpaceWidth(8.0),
                Flexible(
                  child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      // Get payment method
                      final paymentMethod = state.maybeWhen(
                        orElse: () => 'Cash',
                        loaded: (model, orderId) =>
                            model.paymentMethod.isNotEmpty
                                ? model.paymentMethod
                                : 'Cash',
                      );

                      // Get payment amount with fallback
                      final paymentAmount = state.maybeWhen(
                        orElse: () => widget.totalPrice,
                        loaded: (model, orderId) => model.paymentAmount > 0
                            ? model.paymentAmount
                            : widget.totalPrice,
                      );

                      // Calculate change
                      final kembalian = paymentMethod == 'Cash'
                          ? (paymentAmount > widget.totalPrice
                              ? paymentAmount - widget.totalPrice
                              : 0)
                          : 0;

                      // Get cashier name
                      final namaKasir = state.maybeWhen(
                        orElse: () => 'Kasir',
                        loaded: (model, orderId) => model.namaKasir.isNotEmpty
                            ? model.namaKasir
                            : 'Kasir',
                      );

                      // Get table number
                      final tableNumber = state.maybeWhen(
                        orElse: () => 0,
                        loaded: (model, orderId) => model.tableNumber ?? 0,
                      );

                      final orderTypeFromState = state.maybeWhen(
                        orElse: () => widget.orderType,
                        loaded: (model, orderId) => model.orderType.isNotEmpty
                            ? model.orderType
                            : widget.orderType,
                      );

                      return Button.filled(
                        onPressed: _isPrinting
                            ? () {} // Empty function instead of null
                            : () async {
                                try {
                                  setState(() {
                                    _isPrinting = true;
                                  });

                                  // Log for debugging
                                  log("Print button pressed");
                                  log("Print values - method: $paymentMethod, payment: $paymentAmount, total: ${widget.totalPrice}, change: $kembalian");

                                  // Get receipt size with error handling
                                  final sizeReceipt =
                                      await AuthLocalDataSource()
                                          .getSizeReceipt();

                                  // Default to size 80 if parsing fails
                                  int receiptSize;
                                  try {
                                    receiptSize = int.parse(sizeReceipt);
                                  } catch (e) {
                                    log('Error parsing receipt size: $sizeReceipt');
                                    receiptSize = 80; // Default value
                                  }

                                  // Generate receipt print bytes
                                  final receiptBytes = await PrintDataoutputs
                                      .instance
                                      .printOrderV3(
                                    widget.data, // products
                                    widget.totalQty, // totalQuantity
                                    widget.totalPrice, // totalPrice
                                    paymentMethod, // paymentMethod
                                    paymentAmount, // nominalBayar
                                    kembalian, // kembalian
                                    widget.totalTax, // tax
                                    widget.totalDiscount, // discount
                                    widget.subTotal, // subTotal
                                    widget.totalService, // serviceCharge
                                    namaKasir, // namaKasir
                                    widget.draftName, // customerName
                                    receiptSize, // paper size
                                    orderType:
                                        orderTypeFromState, // Pass the order type
                                  );

                                  // Print the receipt first
                                  log('Printing receipt...');
                                  final receiptResult =
                                      await PrintBluetoothThermal.writeBytes(
                                          receiptBytes);

                                  if (!receiptResult) {
                                    setState(() {
                                      _isPrinting = false;
                                    });
                                    _showPrintStatusDialog(false,
                                        'Gagal mencetak struk. Silakan coba lagi.');
                                    return;
                                  }

                                  // Wait a moment before sending the second print job
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));

                                  // Generate checker print bytes
                                  log('Generating checker print data...');
                                  log('Table number: $tableNumber');
                                  final checkerBytes = await PrintDataoutputs
                                      .instance
                                      .printChecker(
                                    widget.data,
                                    tableNumber,
                                    widget.draftName,
                                    namaKasir,
                                    receiptSize,
                                    orderType:
                                        orderTypeFromState, // Pass the order type
                                  );

                                  // Print the checker
                                  log('Printing checker...');
                                  final checkerResult =
                                      await PrintBluetoothThermal.writeBytes(
                                          checkerBytes);

                                  setState(() {
                                    _isPrinting = false;
                                  });

                                  if (checkerResult) {
                                    _showPrintStatusDialog(true,
                                        'Struk dan checker berhasil dicetak.');
                                  } else {
                                    _showPrintStatusDialog(false,
                                        'Struk berhasil dicetak, tetapi gagal mencetak checker.');
                                  }
                                } catch (e) {
                                  setState(() {
                                    _isPrinting = false;
                                  });
                                  _showPrintStatusDialog(
                                      false, 'Error: ${e.toString()}');
                                  log('Print error: ${e.toString()}');
                                }
                              },
                        label: _isPrinting ? 'Mencetak...' : 'Print',
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
