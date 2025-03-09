import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:seblak_sulthane_app/data/datasources/member_repository.dart';

part 'sync_member_bloc.freezed.dart';
part 'sync_member_event.dart';
part 'sync_member_state.dart';

class SyncMemberBloc extends Bloc<SyncMemberEvent, SyncMemberState> {
  final MemberRepository memberRepository;

  SyncMemberBloc(
    this.memberRepository,
  ) : super(const _Initial()) {
    on<_SyncMember>((event, emit) async {
      emit(const _Loading());
      log('Starting to sync members...');

      // Check for connectivity first
      final isOnline = await memberRepository.isConnected();

      if (!isOnline) {
        log('Device is offline, cannot sync members');
        emit(const _Error('Device is offline, cannot sync members'));
        return;
      }

      final result = await memberRepository.getMembers();

      return result.fold(
        (error) {
          log('Error syncing members: $error');
          emit(_Error(error));
        },
        (memberResponseModel) {
          log('Members sync completed successfully');
          emit(_Loaded(memberResponseModel));
        },
      );
    });
  }
}
