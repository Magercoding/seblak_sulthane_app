// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seblak_sulthane_app/data/dataoutputs/print_dataoutputs.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';
import 'package:intl/intl.dart';

import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/qris/qris_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/success_payment_dialog.dart';
import 'package:seblak_sulthane_app/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../bloc/order/order_bloc.dart';

class PaymentQrisDialog extends StatefulWidget {
  final List<ProductQuantity> items;
  final int discount;
  final int discountAmount;
  final int tax;
  final int serviceCharge;
  final int paymentAmount;
  final String customerName;
  final int tableNumber;
  final String status;
  final String paymentStatus;
  final String paymentMethod;
  final int price;
  final int totalQty;
  final int subTotal;
  const PaymentQrisDialog({
    super.key,
    required this.items,
    required this.discount,
    required this.discountAmount,
    required this.tax,
    required this.serviceCharge,
    required this.paymentAmount,
    required this.customerName,
    required this.tableNumber,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.price,
    required this.totalQty,
    required this.subTotal,
  });

  @override
  State<PaymentQrisDialog> createState() => _PaymentQrisDialogState();
}

class _PaymentQrisDialogState extends State<PaymentQrisDialog> {
  String orderId = '';
  Timer? timer;

  WidgetsToImageController controller = WidgetsToImageController();
  @override
  void initState() {
    orderId = DateTime.now().millisecondsSinceEpoch.toString();
    context.read<QrisBloc>().add(QrisEvent.generateQRCode(
          orderId,
          widget.price,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: AppColors.primary,
      content: SizedBox(
        width: context.deviceWidth * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Pembayaran QRIS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            const SpaceHeight(6.0),
            Container(
              width: context.deviceWidth,
              padding: const EdgeInsets.all(14.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: AppColors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocListener<QrisBloc, QrisState>(
                    listener: (context, state) {
                      state.maybeWhen(orElse: () {
                        return;
                      }, qrisResponse: (data) {
                        const onSec = Duration(seconds: 5);
                        timer = Timer.periodic(onSec, (timer) {
                          context
                              .read<QrisBloc>()
                              .add(QrisEvent.checkPaymentStatus(
                                orderId.toString(),
                              ));
                        });
                      }, success: (message) async {
                        context.read<OrderBloc>().add(OrderEvent.order(
                            widget.items,
                            widget.discount,
                            widget.discountAmount,
                            widget.tax,
                            widget.serviceCharge,
                            widget.paymentAmount,
                            widget.customerName,
                            widget.tableNumber,
                            'completed',
                            'paid',
                            'Qris',
                            widget.price));
                        await showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => SuccessPaymentDialog(
                            data: widget.items,
                            totalQty: widget.totalQty,
                            totalPrice: widget.price,
                            totalTax: widget.tax,
                            totalDiscount: widget.discountAmount,
                            subTotal: widget.subTotal,
                            normalPrice: widget.price,
                            totalService: widget.serviceCharge,
                            draftName: widget.customerName,
                          ),
                        );
                      });
                    },
                    child: BlocBuilder<QrisBloc, QrisState>(
                      builder: (context, state) {
                        log('state: $state');
                        return state.maybeWhen(
                          orElse: () {
                            return const SizedBox();
                          },
                          qrisResponse: (data) {
                            log("URL: ${data.actions!.first.url!}");
                            return WidgetsToImage(
                              controller: controller,
                              child: Container(
                                width: 340.0,
                                // height: 256.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Image.network(
                                        data.actions!.first.url!,
                                      ),
                                    ),
                                    // const SpaceHeight(5.0),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                      ).format(widget.price),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          loading: () {
                            return Container(
                              width: 256.0,
                              height: 256.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SpaceHeight(12.0),
                  const Text(
                    'Scan QRIS to make payment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SpaceHeight(12.0),
                  //button print qr
                  ElevatedButton(
                    onPressed: () async {
                      final sizeReceipt =
                          await AuthLocalDataSource().getSizeReceipt();
                      final bytes = await controller.capture();
                      final printValue = await PrintDataoutputs.instance
                          .printQRIS(
                              widget.price, bytes!, int.parse(sizeReceipt));
                      await PrintBluetoothThermal.writeBytes(printValue);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Print QRIS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
