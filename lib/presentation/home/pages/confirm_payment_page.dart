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
import 'package:seblak_sulthane_app/presentation/home/dialog/payment_qris_dialog.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';
import 'package:seblak_sulthane_app/presentation/home/widgets/save_order_dialog.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../bloc/checkout/checkout_bloc.dart';
import '../widgets/order_menu.dart';
import '../widgets/success_payment_dialog.dart';

class ConfirmPaymentPage extends StatefulWidget {
  final bool isTable;
  final TableModel? table;
  const ConfirmPaymentPage({
    super.key,
    required this.isTable,
    this.table,
  });

  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  final totalPriceController = TextEditingController();
  final customerController = TextEditingController();
  bool isPayNow = true;
  bool isCash = true;
  TableModel? selectTable;
  int discountAmount = 0;
  int priceValue = 0;
  int uangPas = 0;
  int uangPas2 = 0;
  int uangPas3 = 0;
  // int discountAmountValue = 0;
  int totalPriceFinal = 0;
  // int taxFinal = 0;
  // int serviceChargeFinal = 0;

  @override
  void initState() {
    context
        .read<GetTableStatusBloc>()
        .add(GetTableStatusEvent.getTablesStatus('available'));
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
                                      : 'Orders #1',
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
                                      if (discountModel == null) {
                                        return 0;
                                      }
                                      return discountModel.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
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
                              'Pajak PB1',
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
                                      if (discountModel == null) {
                                        return 0;
                                      }
                                      return discountModel.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
                                    });

                                final subTotal =
                                    price - (discount / 100 * price);
                                final finalTax = subTotal * (tax / 100);
                                final finalDiscount = discount / 100 * subTotal;
                                // discountAmountValue = finalDiscount.toInt();
                                // taxFinal = finalTax.toInt();
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

                                // serviceChargeFinal =
                                //     nominalServiceCharge.toInt();
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
                                      if (discountModel == null) {
                                        return 0;
                                      }
                                      return discountModel.value!
                                          .replaceAll('.00', '')
                                          .toIntegerFromText;
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

                                final subTotal =
                                    price - (discount / 100 * price);
                                final finalTax = subTotal * (tax / 100);
                                final service =
                                    (serviceCharge / 100) * subTotal;
                                final total = subTotal + finalTax + service;

                                totalPriceController.text =
                                    total.ceil().currencyFormatRpV2;
                                uangPas = total.ceil();
                                uangPas2 = uangPas ~/ 50000 * 50000 + 50000;
                                uangPas3 = uangPas ~/ 50000 * 50000 + 100000;
                                totalPriceFinal = total.ceil();
                                // log("totalPriceFinal: $totalPriceFinal");
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
                  child: ListView(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.isTable != true) ...[
                              const Text(
                                'Pembayaran',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SpaceHeight(16.0),
                              Row(
                                children: [
                                  isPayNow
                                      ? Button.filled(
                                          width: 180.0,
                                          height: 52.0,
                                          onPressed: () {
                                            isPayNow = true;
                                            setState(() {});
                                          },
                                          label: 'Bayar Sekarang',
                                        )
                                      : Button.outlined(
                                          width: 180.0,
                                          height: 52.0,
                                          onPressed: () {
                                            isPayNow = true;
                                            setState(() {});
                                          },
                                          label: 'Bayar Sekarang'),
                                  SpaceWidth(16),
                                  isPayNow
                                      ? Button.outlined(
                                          width: 180.0,
                                          height: 52.0,
                                          onPressed: () {
                                            isPayNow = false;
                                            setState(() {});
                                          },
                                          label: 'Bayar Nanti')
                                      : Button.filled(
                                          width: 180.0,
                                          height: 52.0,
                                          onPressed: () {
                                            isPayNow = false;
                                            setState(() {});
                                          },
                                          label: 'Bayar Nanti',
                                        )
                                ],
                              ),
                            ],
                            const SpaceHeight(8.0),
                            if (!isPayNow) ...[
                              const Divider(),
                              const SpaceHeight(8.0),
                              const Text(
                                'Nomor Meja',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SpaceHeight(12.0),
                              BlocBuilder<GetTableStatusBloc,
                                      GetTableStatusState>(
                                  builder: (context, state) {
                                return state.maybeWhen(
                                  orElse: () =>
                                      const CircularProgressIndicator(),
                                  success: (tables) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<TableModel>(
                                          isExpanded: true,
                                          value: selectTable,
                                          onChanged: (TableModel? newValue) {
                                            setState(() {
                                              selectTable = newValue;
                                            });
                                          },
                                          items: tables
                                              .map<
                                                  DropdownMenuItem<TableModel>>(
                                                (TableModel value) =>
                                                    DropdownMenuItem<
                                                        TableModel>(
                                                  value: value,
                                                  child: Text(
                                                      'Table ${value.tableNumber}'),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
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
                            const SpaceHeight(8.0),
                            if (isPayNow) ...[
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
                                          label: 'Cash',
                                        )
                                      : Button.outlined(
                                          width: 120.0,
                                          height: 50.0,
                                          onPressed: () {
                                            isCash = true;
                                            setState(() {});
                                          },
                                          label: 'Cash',
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
                                          label: 'QRIS',
                                        )
                                      : Button.filled(
                                          width: 120.0,
                                          height: 50.0,
                                          onPressed: () {
                                            isCash = false;
                                            setState(() {});
                                          },
                                          label: 'QRIS',
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      hintText: 'Total harga',
                                    ),
                                    onChanged: (value) {
                                      priceValue = value.toIntegerFromText;
                                      final int newValue =
                                          value.toIntegerFromText;
                                      totalPriceController.text =
                                          newValue.currencyFormatRp;
                                      totalPriceController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
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
                                          totalPriceController.text = uangPas
                                              .toString()
                                              .currencyFormatRpV2;
                                          priceValue = uangPas;
                                        },
                                        label: 'UANG PAS',
                                      ),
                                      const SpaceWidth(20.0),
                                      Button.filled(
                                        width: 150.0,
                                        onPressed: () {
                                          totalPriceController.text = uangPas2
                                              .toString()
                                              .currencyFormatRpV2;
                                          priceValue = uangPas2;
                                        },
                                        label: uangPas2
                                            .toString()
                                            .currencyFormatRpV2,
                                      ),
                                      const SpaceWidth(20.0),
                                      Button.filled(
                                        width: 150.0,
                                        onPressed: () {
                                          totalPriceController.text = uangPas3
                                              .toString()
                                              .currencyFormatRpV2;
                                          priceValue = uangPas3;
                                        },
                                        label: uangPas3
                                            .toString()
                                            .currencyFormatRpV2,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ]
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
                                            startTime: DateTime.now()
                                                .toIso8601String(),
                                          );
                                          log('new tabel: ${newTabel.toMap()}');
                                          context
                                              .read<StatusTableBloc>()
                                              .add(StatusTableEvent.statusTabel(
                                                newTabel,
                                              ));
                                        });
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
                                            if (discountModel == null) {
                                              return 0;
                                            }
                                            return discountModel.value!
                                                .replaceAll('.00', '')
                                                .toIntegerFromText;
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

                                      final subTotal =
                                          price - (discount / 100 * price);
                                      final totalDiscount =
                                          discount / 100 * price;
                                      final finalTax = subTotal * 0.11;
                                      final totalServiceCharge =
                                          (serviceCharge / 100) * price;

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

                                      return Flexible(
                                        child: Button.filled(
                                          onPressed: () async {
                                            if (widget.isTable) {
                                              log("discountAmountValue: $totalDiscount");
                                              context.read<CheckoutBloc>().add(
                                                    CheckoutEvent
                                                        .saveDraftOrder(
                                                      widget.isTable == true
                                                          ? widget.table!.id!
                                                          : selectTable!
                                                              .tableNumber,
                                                      customerController.text,
                                                      totalDiscount.toInt(),
                                                    ),
                                                  );
                                              await showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) =>
                                                    SaveOrderDialog(
                                                  data: items,
                                                  totalQty: totalQty,
                                                  totalPrice: totalPriceFinal,
                                                  totalTax: finalTax.toInt(),
                                                  totalDiscount:
                                                      totalDiscount.toInt(),
                                                  subTotal: subTotal.toInt(),
                                                  normalPrice: price,
                                                  table: widget.table!,
                                                  draftName:
                                                      customerController.text,
                                                ),
                                              );
                                            } else if (isPayNow) {
                                              // context.read<CheckO>().add(
                                              //     OrderEvent.addPaymentMethod(
                                              //         items,
                                              //         totalPrice,
                                              //         finalTax,
                                              //         discount != null
                                              //             ? discount.value
                                              //                 .replaceAll(
                                              //                     '.00', '')
                                              //                 .toIntegerFromText
                                              //             : 0,
                                              //         finalDiscountAmount,
                                              //         finalService,
                                              //         subTotal,
                                              //         totalPriceController.text
                                              //             .toIntegerFromText,
                                              //         auth?.user.name ?? '-',
                                              //         totalQuantity,
                                              //         auth?.user.id ?? 1,
                                              //         isCash
                                              //             ? 'Cash'
                                              //             : 'QR Pay'));
                                              if (isCash) {
                                                log("discountAmountValue: $totalDiscount");
                                                context.read<OrderBloc>().add(
                                                    OrderEvent.order(
                                                        items,
                                                        discount,
                                                        totalDiscount.toInt(),
                                                        finalTax.toInt(),
                                                        0,
                                                        totalPriceController
                                                            .text
                                                            .toIntegerFromText,
                                                        customerController.text,
                                                        0,
                                                        'completed',
                                                        'paid',
                                                        'Cash',
                                                        totalPriceFinal));
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
                                                        totalServiceCharge
                                                            .toInt(),
                                                    draftName:
                                                        customerController.text,
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      PaymentQrisDialog(
                                                    price: totalPriceFinal,
                                                    items: items,
                                                    totalQty: totalQty,
                                                    tax: finalTax.toInt(),
                                                    discountAmount:
                                                        totalDiscount.toInt(),
                                                    subTotal: subTotal.toInt(),
                                                    customerName:
                                                        customerController.text,
                                                    discount: discount,
                                                    paymentAmount:
                                                        totalPriceController
                                                            .text
                                                            .toIntegerFromText,
                                                    paymentMethod: 'Qris',
                                                    tableNumber: 0,
                                                    paymentStatus: 'paid',
                                                    serviceCharge: 0,
                                                    status: 'completed',
                                                  ),
                                                );
                                              }
                                            } else {
                                              context.read<CheckoutBloc>().add(
                                                    CheckoutEvent
                                                        .saveDraftOrder(
                                                      widget.isTable == true
                                                          ? widget.table!.id!
                                                          : selectTable!
                                                              .tableNumber,
                                                      customerController.text,
                                                      totalDiscount.toInt(),
                                                    ),
                                                  );
                                              await showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) =>
                                                    SaveOrderDialog(
                                                  data: items,
                                                  totalQty: totalQty,
                                                  totalPrice: totalPriceFinal,
                                                  totalTax: finalTax.toInt(),
                                                  totalDiscount:
                                                      totalDiscount.toInt(),
                                                  subTotal: subTotal.toInt(),
                                                  normalPrice: price,
                                                  table: selectTable!,
                                                  draftName:
                                                      customerController.text,
                                                ),
                                              );
                                            }
                                          },
                                          label: isPayNow
                                              ? 'Bayar'
                                              : 'Simpan Order',
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
