part of 'history_order_bloc.dart';

@freezed
class HistoryOrderEvent with _$HistoryOrderEvent {
  const factory HistoryOrderEvent.started() = _Started;
  const factory HistoryOrderEvent.getOrdersByDate(DateTime date) = _GetOrdersByDate;
  const factory HistoryOrderEvent.getOrderItemsByOrderId(int orderId) = _GetOrderItemsByOrderId;
}