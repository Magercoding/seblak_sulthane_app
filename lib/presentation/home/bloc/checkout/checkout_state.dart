part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  const factory CheckoutState.loaded(
      List<ProductQuantity> items,
      List<Discount> discounts, // Ubah dari Discount? menjadi List<Discount>
      int discount,
      int discountAmount,
      int tax,
      int serviceCharge,
      int totalQuantity,
      int totalPrice,
      String draftName) = _Loaded;
  const factory CheckoutState.error(String message) = _Error;
  const factory CheckoutState.savedDraftOrder(int orderId) = _SavedDraftOrder;
}
