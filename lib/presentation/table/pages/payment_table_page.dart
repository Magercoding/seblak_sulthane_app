import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/get_table_status/get_table_status_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/order/order_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/status_table/status_table_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/order_menu.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/success_payment_dialog.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_model.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class PaymentTablePage extends StatefulWidget {
  final DraftOrderModel? draftOrder;
  final TableModel? table;
  final String orderType; // Add this parameter
  final bool isTable;

  const PaymentTablePage({
    super.key,
    this.draftOrder,
    this.table,
    required this.isTable,
    required this.orderType, // Add this parameter
  });

  @override
  State<PaymentTablePage> createState() => _PaymentTablePageState();
}

class _PaymentTablePageState extends State<PaymentTablePage> {
  final totalPriceController = TextEditingController();
  final customerController = TextEditingController();
  String orderTypeDisplay = ''; // Added to show order type in UI

  bool isCash = true;
  int totalPriceFinal = 0;
  int discountAmountFinal = 0;
  @override
  void initState() {
    context
        .read<GetTableStatusBloc>()
        .add(GetTableStatusEvent.getTablesStatus('available'));
    orderTypeDisplay =
        widget.orderType == 'take_away' ? 'Take Away' : 'Dine In';
    super.initState();
  }

  @override
  void dispose() {
    totalPriceController.dispose();
    customerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: 'confirmation_screen',
        child: Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Konfirmasi',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  widget.isTable
                                      ? 'Orders Table ${widget.table?.tableNumber}'
                                      : 'Orders #1 - $orderTypeDisplay',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                height: 60.0,
                                width: 60.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (!widget.isTable) ...[
                          const SpaceHeight(12.0),
                          Row(
                            children: [
                              const Text(
                                'Tipe Pesanan:',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SpaceWidth(8.0),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.orderType == 'take_away'
                                      ? AppColors.primary.withOpacity(0.2)
                                      : Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  orderTypeDisplay,
                                  style: TextStyle(
                                    color: widget.orderType == 'take_away'
                                        ? AppColors.primary
                                        : Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8.0),
                          const Divider(),
                        ],
                        const SpaceHeight(24.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 160,
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8),
                        const Divider(),
                        const SpaceHeight(8),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () => const Center(
                                child: Text('No Items'),
                              ),
                              loaded: (products,
                                  discountModel,
                                  discount,
                                  discountAmount,
                                  tax,
                                  serviceCharge,
                                  totalQuantity,
                                  totalPrice,
                                  draftName) {
                                if (products.isEmpty) {
                                  return const Center(
                                    child: Text('No Items'),
                                  );
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      OrderMenu(data: products[index]),
                                  separatorBuilder: (context, index) =>
                                      const SpaceHeight(16.0),
                                  itemCount: products.length,
                                );
                              },
                            );
                          },
                        ),
                        const SpaceHeight(16.0),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sub total',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products,
                                            discountModel,
                                            discount,
                                            discountAmount,
                                            tax,
                                            serviceCharge,
                                            totalQuantity,
                                            totalPrice,
                                            draftName) =>
                                        products.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element.product.price!
                                                      .toIntegerFromText *
                                                  element.quantity),
                                        ));
                                return Text(
                                  price.currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Diskon',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products,
                                        discountModel,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      log("discountAmount: $discountAmount");
                                      return discountAmount;
                                    });

                                discountAmountFinal = discount.toInt();

                                return Text(
                                  discount.toInt().currencyFormatRp,
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pajak',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final tax = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      tax,
                                );
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price!
                                                .toIntegerFromText *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products,
                                        discountModel,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      return discountAmount;
                                    });

                                final subTotal = price - discount;
                                final finalTax = subTotal * (tax / 100);
                                return Text(
                                  '$tax % (${finalTax.toInt().currencyFormatRp})',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Biaya Layanan',
                              style: TextStyle(color: AppColors.grey),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final tax = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      tax,
                                );
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price!
                                                .toIntegerFromText *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products,
                                        discountModel,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      return discountAmount;
                                    });

                                final serviceCharge = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      serviceCharge,
                                );

                                final subTotal = price - discount;
                                final finalServiceCharge =
                                    subTotal * (serviceCharge / 100);

                                return Text(
                                  '$serviceCharge % (${finalServiceCharge.toInt().currencyFormatRp}) ',
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            BlocBuilder<CheckoutBloc, CheckoutState>(
                              builder: (context, state) {
                                final price = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      products.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.product.price!
                                                .toIntegerFromText *
                                            element.quantity),
                                  ),
                                );

                                final discount = state.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (products,
                                        discountModel,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      return discountAmount;
                                    });

                                final serviceCharge = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      serviceCharge,
                                );

                                final tax = state.maybeWhen(
                                  orElse: () => 0,
                                  loaded: (products,
                                          discountModel,
                                          discount,
                                          discountAmount,
                                          tax,
                                          serviceCharge,
                                          totalQuantity,
                                          totalPrice,
                                          draftName) =>
                                      tax,
                                );

                                final subTotal = price - discount;
                                final finalTax = subTotal * (tax / 100);
                                final service =
                                    subTotal * (serviceCharge / 100);
                                final total = subTotal + finalTax + service;
                                totalPriceFinal = total.ceil();
                                totalPriceController.text =
                                    total.ceil().toString();
                                return Text(
                                  total.ceil().currencyFormatRp,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.isTable != true) ...[
                                Row(
                                  children: [
                                    const Text(
                                      'Pembayaran',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SpaceWidth(12.0),
                                    // Order Type Badge
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: widget.orderType == 'take_away'
                                            ? AppColors.primary.withOpacity(0.2)
                                            : Colors.green.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        orderTypeDisplay,
                                        style: TextStyle(
                                          color: widget.orderType == 'take_away'
                                              ? AppColors.primary
                                              : Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SpaceHeight(16.0),
                              ],
                              const Text(
                                'Customer',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SpaceHeight(12.0),
                              BlocBuilder<CheckoutBloc, CheckoutState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () {
                                      return SizedBox.shrink();
                                    },
                                    loaded: (items,
                                        discountModel,
                                        discount,
                                        discountAmount,
                                        tax,
                                        serviceCharge,
                                        totalQuantity,
                                        totalPrice,
                                        draftName) {
                                      customerController.text = draftName;
                                      return TextFormField(
                                        readOnly: true,
                                        controller: customerController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          hintText: 'Nama Customer',
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const SpaceHeight(8.0),
                              const Divider(),
                              const SpaceHeight(8.0),
                              const Text(
                                'Metode Bayar',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SpaceHeight(12.0),
                              Row(
                                children: [
                                  isCash
                                      ? Button.filled(
                                          width: 120.0,
                                          height: 50.0,
                                          onPressed: () {
                                            isCash = true;
                                            setState(() {});
                                          },
                                          label: 'cash',
                                        )
                                      : Button.outlined(
                                          width: 120.0,
                                          height: 50.0,
                                          onPressed: () {
                                            isCash = true;
                                            setState(() {});
                                          },
                                          label: 'cash',
                                        ),
                                  const SpaceWidth(8.0),
                                  isCash
                                      ? Button.outlined(
                                          width: 120.0,
                                          height: 50.0,
                                          onPressed: () {
                                            isCash = false;
                                            setState(() {});
                                          },
                                          label: 'qris',
                                        )
                                      : Button.filled(
                                          width: 120.0,
                                          height: 50.0,
                                          onPressed: () {
                                            isCash = false;
                                            setState(() {});
                                          },
                                          label: 'qris',
                                        ),
                                ],
                              ),
                              const SpaceHeight(8.0),
                              const Divider(),
                              const SpaceHeight(8.0),
                              const Text(
                                'Total Bayar',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SpaceHeight(12.0),
                              TextFormField(
                                controller: totalPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  hintText: 'Total harga',
                                ),
                              ),
                              const SpaceHeight(45.0),
                              Row(
                                children: [
                                  Button.filled(
                                    width: 150.0,
                                    onPressed: () {},
                                    label: 'UANG PAS',
                                  ),
                                  const SpaceWidth(20.0),
                                  Button.filled(
                                    width: 150.0,
                                    onPressed: () {},
                                    label: 'Rp 250.000',
                                  ),
                                  const SpaceWidth(20.0),
                                  Button.filled(
                                    width: 150.0,
                                    onPressed: () {},
                                    label: 'Rp 300.000',
                                  ),
                                ],
                              ),
                              const SpaceHeight(100.0),
                            ]),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ColoredBox(
                          color: AppColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 16.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Button.outlined(
                                    onPressed: () => context.pop(),
                                    label: 'Batalkan',
                                  ),
                                ),
                                const SpaceWidth(8.0),
                                BlocListener<OrderBloc, OrderState>(
                                  listener: (context, state) {
                                    final newTable = TableModel(
                                      id: widget.table!.id,
                                      tableNumber: widget.table!.tableNumber,
                                      status: 'available',
                                      orderId: 0,
                                      paymentAmount: 0,
                                      startTime:
                                          DateTime.now().toUtc().toIso8601String(),
                                    );
                                    context.read<StatusTableBloc>().add(
                                          StatusTableEvent.statusTabel(
                                            newTable,
                                          ),
                                        );
                                    ProductLocalDatasource.instance
                                        .removeDraftOrderById(
                                            widget.draftOrder!.id!);
                                  },
                                  child:
                                      BlocBuilder<CheckoutBloc, CheckoutState>(
                                    builder: (context, state) {
                                      final discount = state.maybeWhen(
                                          orElse: () => 0,
                                          loaded: (products,
                                              discountModel,
                                              discount,
                                              discountAmount,
                                              tax,
                                              serviceCharge,
                                              totalQuantity,
                                              totalPrice,
                                              draftName) {
                                            if (discountModel.isEmpty) {
                                              return 0;
                                            }
                                            return discount;
                                          });

                                      final price = state.maybeWhen(
                                        orElse: () => 0,
                                        loaded: (products,
                                                discountModel,
                                                discount,
                                                discountAmount,
                                                tax,
                                                serviceCharge,
                                                totalQuantity,
                                                totalPrice,
                                                draftName) =>
                                            products.fold(
                                          0,
                                          (previousValue, element) =>
                                              previousValue +
                                              (element.product.price!
                                                      .toIntegerFromText *
                                                  element.quantity),
                                        ),
                                      );

                                      final subTotal =
                                          price - (discount / 100 * price);
                                      final totalDiscount =
                                          discount / 100 * price;
                                      final finalTax = subTotal * 0.11;

                                      List<ProductQuantity> items =
                                          state.maybeWhen(
                                        orElse: () => [],
                                        loaded: (products,
                                                discountModel,
                                                discount,
                                                discountAmount,
                                                tax,
                                                serviceCharge,
                                                totalQuantity,
                                                totalPrice,
                                                draftName) =>
                                            products,
                                      );
                                      final totalQty = items.fold(
                                        0,
                                        (previousValue, element) =>
                                            previousValue + element.quantity,
                                      );

                                      final totalPrice = subTotal + finalTax;

                                      return Flexible(
                                        child: Button.filled(
                                          onPressed: () async {
                                            context
                                                .read<OrderBloc>()
                                                .add(OrderEvent.order(
                                                  items,
                                                  discount,
                                                  discountAmountFinal,
                                                  finalTax.toInt(),
                                                  0,
                                                  totalPriceController
                                                      .text.toIntegerFromText,
                                                  customerController.text,
                                                  widget.table?.id ?? 0,
                                                  'completed',
                                                  'paid',
                                                  isCash ? 'cash' : 'qris',
                                                  totalPriceFinal,
                                                  orderType:
                                                      'dine_in', // Always use 'dine_in' for tables
                                                ));

                                            await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  SuccessPaymentDialog(
                                                data: items,
                                                totalQty: totalQty,
                                                totalPrice:
                                                    totalPriceFinal.toInt(),
                                                totalTax: finalTax.toInt(),
                                                totalDiscount:
                                                    totalDiscount.toInt(),
                                                subTotal: subTotal.toInt(),
                                                normalPrice: price,
                                                totalService: 0,
                                                draftName:
                                                    customerController.text,
                                                orderType:
                                                    'dine_in', // Add this missing parameter
                                              ),
                                            );
                                          },
                                          label: 'Bayar',
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
