import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  State<SuccessPaymentDialog> createState() => _SuccessPaymentDialogState();
}

class _SuccessPaymentDialogState extends State<SuccessPaymentDialog> {
  // Add a loading state to show during printing
  bool _isPrinting = false;

  // Show print status dialog
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
            const Text('METODE BAYAR'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentMethod = state.maybeWhen(
                  orElse: () => 'Cash',
                  loaded: (model, orderId) => model.paymentMethod,
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
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final total = state.maybeWhen(
                  orElse: () => 0,
                  loaded: (model, orderId) => model.total,
                );
                return Text(
                  widget.totalPrice.currencyFormatRp,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const SpaceHeight(10.0),
            const Divider(),
            const SpaceHeight(8.0),
            const Text('NOMINAL BAYAR'),
            const SpaceHeight(5.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final paymentAmount = state.maybeWhen(
                  orElse: () => 0,
                  loaded: (model, orderId) => model.paymentAmount,
                );
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
                  loaded: (model, orderId) => model.paymentMethod,
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
                          final paymentAmount = state.maybeWhen(
                            orElse: () => 0,
                            loaded: (model, orderId) => model.paymentAmount,
                          );
                          final total = state.maybeWhen(
                            orElse: () => 0,
                            loaded: (model, orderId) => model.total,
                          );
                          final diff = paymentAmount - total;
                          log("DIFF: $diff  paymentAmount: $paymentAmount  total: $total");
                          return Text(
                            diff.ceil().currencyFormatRp,
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
                      final paymentAmount = state.maybeWhen(
                        orElse: () => 0,
                        loaded: (model, orderId) => model.paymentAmount,
                      );

                      final paymentMethod = state.maybeWhen(
                        orElse: () => 'Cash',
                        loaded: (model, orderId) => model.paymentMethod,
                      );

                      final kembalian = paymentMethod == 'Cash'
                          ? paymentAmount - widget.totalPrice
                          : 0;

                      // Update the onPressed callback in SuccessPaymentDialog
                      return Button.filled(
                        onPressed: _isPrinting
                            ? () {} // Empty function instead of null while printing
                            : () async {
                                try {
                                  setState(() {
                                    _isPrinting = true;
                                  });

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

                                  final paymentMethod = state.maybeWhen(
                                    orElse: () => 'Cash',
                                    loaded: (model, orderId) =>
                                        model.paymentMethod,
                                  );

                                  final paymentAmount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (model, orderId) =>
                                        model.paymentAmount,
                                  );

                                  final namaKasir = state.maybeWhen(
                                    orElse: () => 'Kasir',
                                    loaded: (model, orderId) => model.namaKasir,
                                  );

                                  // Get table number from order state if available, default to 0 (no table)
                                  final tableNumber = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (model, orderId) =>
                                        model.tableNumber ?? 0,
                                  );

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
                                    tableNumber, // This can be 0 now and will be handled appropriately
                                    widget.draftName,
                                    namaKasir,
                                    receiptSize,
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
