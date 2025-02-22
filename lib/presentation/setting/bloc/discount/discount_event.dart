part of 'discount_bloc.dart';

@freezed
class DiscountEvent with _$DiscountEvent {
  const factory DiscountEvent.started() = _Started;
  const factory DiscountEvent.getDiscounts() = _GetDiscounts;
  const factory DiscountEvent.addDiscount({
    required String name,
    required String description,
    required double value,
    required String category,
  }) = _AddDiscount;
  const factory DiscountEvent.updateDiscount({
    required int id,
    required String name,
    required String description,
    required double value,
    required String category,
  }) = _UpdateDiscount;
  const factory DiscountEvent.deleteDiscount(int id) = _DeleteDiscount;
}
