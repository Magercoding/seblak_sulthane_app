import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:seblak_sulthane_app/core/core.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/order_item.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_item.dart';
import 'package:seblak_sulthane_app/presentation/table/models/draft_order_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/response/product_response_model.dart';
import '../../models/product_quantity.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([], [], 0, 0, 10, 5, 0, 0, '')) {
    on<_AddItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQuantity> items = [...currentState.items];
      var index =
          items.indexWhere((element) => element.product.id == event.product.id);
      emit(_Loading());
      if (index != -1) {
        items[index] = ProductQuantity(
            product: event.product, quantity: items[index].quantity + 1);
      } else {
        items.add(ProductQuantity(product: event.product, quantity: 1));
      }
      emit(_Loaded(
          items,
          currentState.discounts,
          currentState.discount,
          currentState.discountAmount,
          currentState.tax,
          currentState.serviceCharge,
          currentState.totalQuantity,
          currentState.totalPrice,
          currentState.draftName));
    });

    on<_RemoveItem>((event, emit) {
      var currentState = state as _Loaded;
      List<ProductQuantity> items = [...currentState.items];
      var index =
          items.indexWhere((element) => element.product.id == event.product.id);
      emit(_Loading());
      if (index != -1) {
        if (items[index].quantity > 1) {
          items[index] = ProductQuantity(
              product: event.product, quantity: items[index].quantity - 1);
        } else {
          items.removeAt(index);
        }
      }
      emit(_Loaded(
          items,
          currentState.discounts,
          currentState.discount,
          currentState.discountAmount,
          currentState.tax,
          currentState.serviceCharge,
          currentState.totalQuantity,
          currentState.totalPrice,
          currentState.draftName));
    });

    on<_Started>((event, emit) {
      emit(const _Loaded([], [], 11, 0, 0, 0, 0, 0, ''));
    });

    on<_AddDiscount>((event, emit) {
      var currentState = state as _Loaded;
      List<Discount> currentDiscounts = [...currentState.discounts];

      int index = currentDiscounts
          .indexWhere((d) => d.category == event.discount.category);

      if (index != -1) {
        currentDiscounts[index] = event.discount;
      } else {
        currentDiscounts.add(event.discount);
      }

      int totalDiscountPercentage = currentDiscounts.fold(
        0,
        (sum, discount) =>
            sum + int.parse(discount.value!.replaceAll('.00', '')),
      );

      final totalPrice = currentState.items.fold(
        0,
        (sum, item) =>
            sum + (item.product.price!.toIntegerFromText * item.quantity),
      );

      final discountAmount =
          (totalPrice * totalDiscountPercentage / 100).round();

      emit(_Loaded(
        currentState.items,
        currentDiscounts,
        totalDiscountPercentage,
        discountAmount,
        currentState.tax,
        currentState.serviceCharge,
        currentState.totalQuantity,
        totalPrice - discountAmount,
        currentState.draftName,
      ));
    });
    on<_RemoveDiscount>((event, emit) {
      var currentState = state as _Loaded;
      List<Discount> currentDiscounts = [...currentState.discounts];

      currentDiscounts.removeWhere((d) => d.category == event.category);

      int totalDiscountPercentage = currentDiscounts.fold(
        0,
        (sum, discount) =>
            sum + int.parse(discount.value!.replaceAll('.00', '')),
      );

      final totalPrice = currentState.items.fold(
        0,
        (sum, item) =>
            sum + (item.product.price!.toIntegerFromText * item.quantity),
      );

      final discountAmount =
          (totalPrice * totalDiscountPercentage / 100).round();

      emit(_Loaded(
        currentState.items,
        currentDiscounts,
        totalDiscountPercentage,
        discountAmount,
        currentState.tax,
        currentState.serviceCharge,
        currentState.totalQuantity,
        totalPrice - discountAmount,
        currentState.draftName,
      ));
    });

    on<_AddTax>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(
          currentState.items,
          currentState.discounts,
          currentState.discount,
          currentState.discountAmount,
          event.tax,
          currentState.serviceCharge,
          currentState.totalQuantity,
          currentState.totalPrice,
          currentState.draftName));
    });

    on<_AddServiceCharge>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(
        currentState.items,
        currentState.discounts,
        currentState.discount,
        currentState.discountAmount,
        currentState.tax,
        event.serviceCharge,
        currentState.totalQuantity,
        currentState.totalPrice,
        currentState.draftName,
      ));
    });

    on<_RemoveTax>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(
          currentState.items,
          currentState.discounts,
          currentState.discount,
          currentState.discountAmount,
          0,
          currentState.serviceCharge,
          currentState.totalQuantity,
          currentState.totalPrice,
          currentState.draftName));
    });

    on<_RemoveServiceCharge>((event, emit) {
      var currentState = state as _Loaded;
      emit(_Loaded(
          currentState.items,
          currentState.discounts,
          currentState.discount,
          currentState.discountAmount,
          currentState.tax,
          0,
          currentState.totalQuantity,
          currentState.totalPrice,
          currentState.draftName));
    });

    on<_SaveDraftOrder>((event, emit) async {
      var currentStates = state as _Loaded;
      emit(const _Loading());

      final draftOrder = DraftOrderModel(
        orders: currentStates.items
            .map((e) => DraftOrderItem(
                  product: e.product,
                  quantity: e.quantity,
                ))
            .toList(),
        totalQuantity: currentStates.totalQuantity,
        totalPrice: currentStates.totalPrice,
        discount: currentStates.discount,
        discountAmount: event.discountAmount,
        tax: currentStates.tax,
        serviceCharge: currentStates.serviceCharge,
        subTotal: currentStates.totalPrice,
        tableNumber: event.tableNumber,
        draftName: event.draftName,
        transactionTime:
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      );
      log("draftOrder12: ${draftOrder.toMapForLocal()}");
      final orderDraftId =
          await ProductLocalDatasource.instance.saveDraftOrder(draftOrder);
      emit(_SavedDraftOrder(orderDraftId));
    });

    on<_LoadDraftOrder>((event, emit) async {
      emit(const _Loading());
      final draftOrder = event.data;
      log("draftOrder: ${draftOrder.toMap()}");
      emit(_Loaded(
          draftOrder.orders
              .map((e) =>
                  ProductQuantity(product: e.product, quantity: e.quantity))
              .toList(),
          [],
          draftOrder.discount,
          draftOrder.discountAmount,
          draftOrder.tax,
          draftOrder.serviceCharge,
          draftOrder.totalQuantity,
          draftOrder.totalPrice,
          draftOrder.draftName));
    });
  }
}
