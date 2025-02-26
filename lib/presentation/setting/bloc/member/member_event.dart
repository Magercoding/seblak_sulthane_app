part of 'member_bloc.dart';

@freezed
class MemberEvent with _$MemberEvent {
  const factory MemberEvent.started() = _Started;
  const factory MemberEvent.getMembers() = _GetMembers;
  const factory MemberEvent.addMember({
    required String name,
    required String phone,
  }) = _AddMember;
  const factory MemberEvent.updateMember({
    required int id,
    required String name,
    required String phone,
  }) = _UpdateMember;
  const factory MemberEvent.deleteMember(int id) = _DeleteMember;
}