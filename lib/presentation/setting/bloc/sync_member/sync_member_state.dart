part of 'sync_member_bloc.dart';

@freezed
class SyncMemberState with _$SyncMemberState {
  const factory SyncMemberState.initial() = _Initial;
  const factory SyncMemberState.loading() = _Loading;
  const factory SyncMemberState.loaded(MemberResponseModel memberResponseModel) = _Loaded;
  const factory SyncMemberState.error(String message) = _Error;
}