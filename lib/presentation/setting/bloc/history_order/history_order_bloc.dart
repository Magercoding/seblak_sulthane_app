import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/product_local_datasource.dart';
import 'package:seblak_sulthane_app/presentation/home/models/order_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/product_quantity.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';
part 'history_order_bloc.freezed.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final ProductLocalDatasource productLocalDatasource;

  HistoryOrderBloc(this.productLocalDatasource) : super(const _Initial()) {
    on<_GetOrdersByDate>((event, emit) async {
      emit(const _Loading());
      try {
        final orders = await productLocalDatasource.getAllOrder(event.date);
        emit(_Loaded(orders));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });

    on<_GetOrderItemsByOrderId>((event, emit) async {
      emit(const _Loading());
      try {
        final orderItems = await productLocalDatasource.getOrderItemByOrderId(event.orderId);
        emit(_LoadedWithItems(orderItems));
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}