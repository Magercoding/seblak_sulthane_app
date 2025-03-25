// lib/presentation/setting/bloc/sync_category/sync_category_event.dart
part of 'sync_category_bloc.dart';

@freezed
class SyncCategoryEvent with _$SyncCategoryEvent {
  const factory SyncCategoryEvent.started() = _Started;
  const factory SyncCategoryEvent.syncCategory() = _SyncCategory;
}
