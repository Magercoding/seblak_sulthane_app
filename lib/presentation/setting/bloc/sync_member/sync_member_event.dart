part of 'sync_member_bloc.dart';

@freezed
class SyncMemberEvent with _$SyncMemberEvent {
  const factory SyncMemberEvent.started() = _Started;
  const factory SyncMemberEvent.syncMember() = _SyncMember;
}