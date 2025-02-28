part of 'sync_discount_bloc.dart';

@freezed
class SyncDiscountEvent with _$SyncDiscountEvent {
  const factory SyncDiscountEvent.started() = _Started;
  const factory SyncDiscountEvent.syncDiscount() = _SyncDiscount;
}