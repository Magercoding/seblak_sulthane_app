part of 'sync_discount_bloc.dart';

@freezed
class SyncDiscountState with _$SyncDiscountState {
  const factory SyncDiscountState.initial() = _Initial;
  const factory SyncDiscountState.loading() = _Loading;
  const factory SyncDiscountState.loaded(DiscountResponseModel discountResponseModel) = _Loaded;
  const factory SyncDiscountState.error(String message) = _Error;
}