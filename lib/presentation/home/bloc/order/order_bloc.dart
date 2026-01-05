import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:seblak_sulthane_app/core/extensions/string_ext.dart';
import 'package:seblak_sulthane_app/core/utils/timezone_helper.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/order_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';

import '../../models/order_model.dart';
import '../../models/product_quantity.dart';

part 'order_bloc.freezed.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource orderRemoteDatasource;
  OrderBloc(
    this.orderRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(const _Loading());
      log("Start Order Process - Payment Method: ${event.paymentMethod}, Amount: ${event.paymentAmount}");

      final subTotal = event.items.fold<int>(
          0,
          (previousValue, element) =>
              previousValue +
              (element.product.price!.toIntegerFromText * element.quantity));

      final totalItem = event.items.fold<int>(
          0, (previousValue, element) => previousValue + element.quantity);

      final userData = await AuthLocalDataSource().getAuthData();

      // Ensure valid payment amount
      final paymentAmount =
          event.paymentAmount > 0 ? event.paymentAmount : event.totalPriceFinal;

      // Ensure valid payment method
      final paymentMethod =
          event.paymentMethod.isNotEmpty ? event.paymentMethod : 'Cash';

      // Use provided order type, but default to table-based logic if not specified
      final String orderType = event.orderType.isNotEmpty
          ? event.orderType
          : (event.tableNumber > 0 ? 'dine_in' : 'take_away');

      log("Payment information to be saved:");
      log("Method: $paymentMethod, Amount: $paymentAmount, Total: ${event.totalPriceFinal}, Order Type: $orderType");

      final dataInput = OrderModel(
        subTotal: subTotal,
        paymentAmount: paymentAmount,
        tax: event.tax,
        discount: event.discount,
        discountAmount: event.discountAmount,
        serviceCharge: event.serviceCharge,
        total: event.totalPriceFinal,
        paymentMethod: paymentMethod,
        totalItem: totalItem,
        idKasir: userData.user?.id ?? 1,
        namaKasir: userData.user?.name ?? 'Kasir A',
        transactionTime: DateTime.now().toUtc().toIso8601String(),
        customerName: event.customerName,
        tableNumber: event.tableNumber,
        status: event.status,
        paymentStatus: event.paymentStatus,
        isSync: 0,
        orderType: orderType, // Add order type
        notes: event.notes,
        orderItems: event.items,
      );

      try {
        // Save to local database first
        int id = await ProductLocalDatasource.instance.saveOrder(dataInput);
        log("Data successfully saved to local database with ID: $id");

        final newData = dataInput.copyWith(id: id);
        final orderItem =
            await ProductLocalDatasource.instance.getOrderItemByOrderId(id);
        final newOrder = newData.copyWith(orderItems: orderItem);

        // Try to sync to server, but don't wait for success
        try {
          final value = await orderRemoteDatasource.saveOrder(newOrder);
          if (value) {
            await ProductLocalDatasource.instance.updateOrderIsSync(id);
            log("Successfully synced to server");
          } else {
            log("Failed to sync to server, but local data is saved");
          }
        } catch (e) {
          log("Error syncing to server: ${e.toString()}");
          // Continue even if sync fails
        }

        // Verify data before emitting
        log("Data sent to UI - method: ${newOrder.paymentMethod}, amount: ${newOrder.paymentAmount}, order type: ${newOrder.orderType}");
        emit(_Loaded(newOrder, id));
      } catch (e) {
        log("Error saving order: ${e.toString()}");

        // Still emit data for UI display
        final fallbackOrder = OrderModel(
          id: 0,
          subTotal: subTotal,
          paymentAmount: paymentAmount,
          tax: event.tax,
          discount: event.discount,
          discountAmount: event.discountAmount,
          serviceCharge: event.serviceCharge,
          total: event.totalPriceFinal,
          paymentMethod: paymentMethod,
          totalItem: totalItem,
          idKasir: userData.user?.id ?? 1,
          namaKasir: userData.user?.name ?? 'Kasir A',
          transactionTime: DateTime.now().toUtc().toIso8601String(),
          customerName: event.customerName,
          tableNumber: event.tableNumber,
          status: event.status,
          paymentStatus: event.paymentStatus,
          isSync: 0,
          orderType: orderType, // Add order type
          notes: event.notes,
          orderItems: event.items,
        );

        emit(_Loaded(fallbackOrder, 0));
      }
    });
    // Add this handler to your OrderBloc class
    on<_LoadHistoricalOrder>((event, emit) {
      emit(const _Loading());

      log("Loading historical order: ID=${event.order.id}, TableNumber=${event.order.tableNumber}");

      // For each product, log the name to verify it's available
      for (var item in event.order.orderItems) {
        log("Item: ${item.product.name ?? 'Unknown'} (ID=${item.product.id}), Qty=${item.quantity}");
      }

      // Emit loaded state with the historical order
      emit(_Loaded(event.order, event.order.id ?? 0));
    });
  }
}
