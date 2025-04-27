part of 'history_order_bloc.dart';

@freezed
class HistoryOrderState with _$HistoryOrderState {
  const factory HistoryOrderState.initial() = _Initial;
  const factory HistoryOrderState.loading() = _Loading;
  const factory HistoryOrderState.loaded(List<OrderModel> orders) = _Loaded;
  const factory HistoryOrderState.loadedWithItems(List<ProductQuantity> orderItems) = _LoadedWithItems;
  const factory HistoryOrderState.error(String message) = _Error;
}