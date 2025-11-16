import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:seblak_sulthane_app/core/extensions/build_context_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/int_ext.dart';
import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/data/models/response/table_model.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/get_table_status/get_table_status_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/order/order_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/bloc/status_table/status_table_bloc.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../widgets/order_menu.dart';
import '../widgets/success_payment_dialog.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final bool isTable;
  final TableModel? table;
  final String orderType; // Add this parameter

  const ConfirmPaymentPage({
    super.key,
    required this.isTable,
    this.table,
    required this.orderType, // Add this parameter
  });

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  final totalPriceController = TextEditingController();
  final customerController = TextEditingController();
  final notesController = TextEditingController();
  bool isCash = true;
  TableModel? selectTable;
  int discountAmount = 0;
  int priceValue = 0;
  int uangPas = 0;
  int uangPas2 = 0;
  int uangPas3 = 0;

  int totalPriceFinal = 0;
  String orderTypeDisplay = ''; // Added to show order type in UI

  void _scheduleTotalPriceUpdate({
    required String formattedText,
    required int rawValue,
  }) {
    priceValue = rawValue;

    if (totalPriceController.text == formattedText) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      totalPriceController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    });
  }

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
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                                    : 'Orders #1 - $orderTypeDisplay', // Show order type for take away
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
                      const SpaceHeight(8.0),
                      const Divider(),
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
                                    const SpaceHeight(12.0),
                                itemCount: products.length,
                              );
                            },
                          );
                        },
                      ),
                      const SpaceHeight(8.0),
                      const Divider(),
                      const SpaceHeight(4.0),
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
                      const SpaceHeight(4.0),
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
                                    if (discountModel.isEmpty) {
                                      return 0;
                                    }
                                    return discount;
                                  });

                              final subTotal = state.maybeWhen(
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

                              final finalDiscount = discount / 100 * subTotal;
                              discountAmount = finalDiscount.toInt();
                              return Text(
                                '$discount % (${finalDiscount.toInt().currencyFormatRp})',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SpaceHeight(4.0),
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
                                    if (discountModel.isEmpty) {
                                      return 0;
                                    }
                                    return discount;
                                  });

                              final subTotal = price - (discount / 100 * price);
                              final finalTax = subTotal * (tax / 100);
                              final finalDiscount = discount / 100 * subTotal;

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
                      const SpaceHeight(4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Biaya Layanan',
                            style: TextStyle(color: AppColors.grey),
                          ),
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
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

                              final nominalServiceCharge =
                                  (serviceCharge / 100) *
                                      (price - discountAmount);

                              return Text(
                                '$serviceCharge % (${nominalServiceCharge.toInt().currencyFormatRp})',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SpaceHeight(10.0),
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
                                    if (discountModel.isEmpty) {
                                      return 0;
                                    }
                                    return discount;
                                  });

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

                              final subTotal = price - (discount / 100 * price);
                              final finalTax = subTotal * (tax / 100);
                              final service = (serviceCharge / 100) * subTotal;
                              final total = subTotal + finalTax + service;

                              final totalCeil = total.ceil();
                              final controllerFormatted =
                                  totalCeil.currencyFormatRp;
                              final displayFormatted =
                                  totalCeil.currencyFormatRpV2;

                              _scheduleTotalPriceUpdate(
                                formattedText: controllerFormatted,
                                rawValue: totalCeil,
                              );

                              uangPas = totalCeil;
                              uangPas2 = uangPas ~/ 50000 * 50000 + 50000;
                              uangPas3 = uangPas ~/ 50000 * 50000 + 100000;
                              totalPriceFinal = totalCeil;

                              return Text(
                                displayFormatted,
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
                child: ListView(
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
                            const SpaceHeight(16.0),
                          ],
                          const SpaceHeight(8.0),
                          const Divider(),
                          const SpaceHeight(8.0),
                          const Text(
                            'Customer',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SpaceHeight(12.0),
                          TextFormField(
                            controller: customerController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Nama Customer',
                            ),
                            textCapitalization: TextCapitalization.words,
                          ),
                          const SpaceHeight(12.0),
                          const Divider(),
                          //Notes
                          const SpaceHeight(12.0),
                          const Text(
                            'Catatan',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SpaceHeight(12.0),
                          TextFormField(
                            controller: notesController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: 'Tuliskan Catatan Pesanan',
                            ),
                            textCapitalization: TextCapitalization.sentences,
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
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              return TextFormField(
                                controller: totalPriceController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  hintText: 'Total harga',
                                ),
                                onChanged: (value) {
                                  priceValue = value.toIntegerFromText;
                                  final int newValue = value.toIntegerFromText;
                                  totalPriceController.text =
                                      newValue.currencyFormatRp;
                                  totalPriceController.selection =
                                      TextSelection.fromPosition(TextPosition(
                                          offset: totalPriceController
                                              .text.length));
                                },
                              );
                            },
                          ),
                          const SpaceHeight(20.0),
                          BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Button.filled(
                                    width: 150.0,
                                    onPressed: () {
                                      totalPriceController.text =
                                          uangPas.toString().currencyFormatRp;
                                      priceValue = uangPas;
                                    },
                                    label: 'UANG PAS',
                                  ),
                                  const SpaceWidth(20.0),
                                  Button.filled(
                                    width: 150.0,
                                    onPressed: () {
                                      totalPriceController.text =
                                          uangPas2.toString().currencyFormatRp;
                                      priceValue = uangPas2;
                                    },
                                    label: uangPas2.toString().currencyFormatRp,
                                  ),
                                  const SpaceWidth(20.0),
                                  Button.filled(
                                    width: 150.0,
                                    onPressed: () {
                                      totalPriceController.text =
                                          uangPas3.toString().currencyFormatRp;
                                      priceValue = uangPas3;
                                    },
                                    label: uangPas3.toString().currencyFormatRp,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
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
                                  label: 'Kembali',
                                ),
                              ),
                              const SpaceWidth(8.0),
                              BlocListener<CheckoutBloc, CheckoutState>(
                                listener: (context, state) {
                                  state.maybeWhen(
                                      orElse: () {},
                                      savedDraftOrder: (orderDraftId) {
                                        final newTabel = TableModel(
                                          id: widget.isTable
                                              ? widget.table!.id
                                              : selectTable?.id,
                                          tableNumber: widget.isTable
                                              ? widget.table!.tableNumber
                                              : selectTable?.tableNumber ?? 0,
                                          status: 'occupied',
                                          paymentAmount: priceValue,
                                          orderId: orderDraftId,
                                          startTime:
                                              DateTime.now().toIso8601String(),
                                        );
                                        log('new tabel: ${newTabel.toMap()}');
                                        context
                                            .read<StatusTableBloc>()
                                            .add(StatusTableEvent.statusTabel(
                                              newTabel,
                                            ));
                                      });
                                },
                                child: BlocBuilder<CheckoutBloc, CheckoutState>(
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

                                    final subTotal =
                                        price - (discount / 100 * price);
                                    final totalDiscount =
                                        discount / 100 * price;
                                    final finalTax = subTotal * (tax / 100);
                                    final totalServiceCharge =
                                        (serviceCharge / 100) * price;
                                    final totalFinal = subTotal +
                                        finalTax +
                                        totalServiceCharge;

                                    return Flexible(
                                      child: Button.filled(
                                        onPressed: () async {
                                          // Show confirmation dialog before payment
                                          final shouldProceed =
                                              await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text(
                                                'Konfirmasi Pembayaran',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Apakah Anda yakin ingin melanjutkan pembayaran?',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SpaceHeight(12.0),
                                                  Text(
                                                    'Total Pembayaran: ${totalFinal.ceil().currencyFormatRpV2}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                  const SpaceHeight(8.0),
                                                  Text(
                                                    'Metode Pembayaran: ${isCash ? 'Cash' : 'QRIS'}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SpaceHeight(16.0),
                                                  const Text(
                                                    'Setelah pembayaran dikonfirmasi, order akan tersimpan dan tidak dapat dibatalkan.',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Button.outlined(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, false),
                                                        label: 'Batal',
                                                      ),
                                                    ),
                                                    const SpaceWidth(8.0),
                                                    Expanded(
                                                      child: Button.filled(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, true),
                                                        label: 'Bayar',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );

                                          if (shouldProceed != true) {
                                            return; // User cancelled
                                          }
                                          if (widget.isTable) {
                                            // For table orders - show SuccessPaymentDialog
                                            log("discountAmountValue: $totalDiscount");
                                            context.read<OrderBloc>().add(
                                                OrderEvent.order(
                                                    items,
                                                    discount,
                                                    totalDiscount.toInt(),
                                                    finalTax.toInt(),
                                                    0,
                                                    totalPriceController
                                                        .text.toIntegerFromText,
                                                    customerController.text,
                                                    widget.table!
                                                        .id!, // Use table ID
                                                    'completed',
                                                    'paid',
                                                    isCash ? 'cash' : 'qris',
                                                    totalPriceFinal,
                                                    orderType: 'dine_in',
                                                    notes:
                                                        notesController.text));

                                            // Update table status to 'closed' after payment
                                            final newTableStatus = TableModel(
                                              id: widget.table!.id,
                                              tableNumber:
                                                  widget.table!.tableNumber,
                                              status:
                                                  'closed', // Change status to 'closed' instead of 'occupied'
                                              paymentAmount: priceValue,
                                              orderId: widget.table!.orderId,
                                              startTime:
                                                  widget.table!.startTime,
                                            );

                                            context.read<StatusTableBloc>().add(
                                                  StatusTableEvent.statusTabel(
                                                      newTableStatus),
                                                );

                                            await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  SuccessPaymentDialog(
                                                data: items,
                                                totalQty: totalQty,
                                                totalPrice: totalPriceFinal,
                                                totalTax: finalTax.toInt(),
                                                totalDiscount:
                                                    totalDiscount.toInt(),
                                                subTotal: subTotal.toInt(),
                                                normalPrice: price,
                                                totalService:
                                                    totalServiceCharge.toInt(),
                                                draftName:
                                                    customerController.text,
                                                orderType: 'dine_in',
                                                notes: notesController.text,
                                              ),
                                            );
                                          } else {
                                            // For non-table orders
                                            log("discountAmountValue: $totalDiscount");
                                            context.read<OrderBloc>().add(
                                                OrderEvent.order(
                                                    items,
                                                    discount,
                                                    totalDiscount.toInt(),
                                                    finalTax.toInt(),
                                                    0,
                                                    totalPriceController
                                                        .text.toIntegerFromText,
                                                    customerController.text,
                                                    0,
                                                    'completed',
                                                    'paid',
                                                    isCash ? 'cash' : 'qris',
                                                    totalPriceFinal,
                                                    orderType: widget.orderType,
                                                    notes:
                                                        notesController.text));
                                            await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (context) =>
                                                  SuccessPaymentDialog(
                                                data: items,
                                                totalQty: totalQty,
                                                totalPrice: totalPriceFinal,
                                                totalTax: finalTax.toInt(),
                                                totalDiscount:
                                                    totalDiscount.toInt(),
                                                subTotal: subTotal.toInt(),
                                                normalPrice: price,
                                                totalService:
                                                    totalServiceCharge.toInt(),
                                                draftName:
                                                    customerController.text,
                                                orderType: widget.orderType,
                                                notes: notesController.text,
                                              ),
                                            );
                                          }
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
    );
  }
}
