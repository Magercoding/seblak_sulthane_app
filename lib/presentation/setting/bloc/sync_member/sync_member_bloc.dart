import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/member_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/member_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';

part 'sync_member_bloc.freezed.dart';
part 'sync_member_event.dart';
part 'sync_member_state.dart';

class SyncMemberBloc extends Bloc<SyncMemberEvent, SyncMemberState> {
  final MemberRemoteDatasource memberRemoteDatasource;

  SyncMemberBloc(
    this.memberRemoteDatasource,
  ) : super(const _Initial()) {
    on<_SyncMember>((event, emit) async {
      emit(const _Loading());
      log('Starting to sync members...');

      final result = await memberRemoteDatasource.getMembers();

      return result.fold(
        (error) {
          log('Error fetching members: $error');
          emit(_Error(error));
        },
        (memberResponseModel) async {
          try {
            log('Successfully fetched members from API');

            await MemberLocalDatasource.instance.deleteAllMembers();
            log('Deleted existing members from local database');

            if (memberResponseModel.data.isNotEmpty) {
              log('Inserting ${memberResponseModel.data.length} members to local database');
              await MemberLocalDatasource.instance.insertMembers(
                memberResponseModel.data,
              );
              log('Members sync completed successfully');
              emit(_Loaded(memberResponseModel));
            } else {
              log('No member data available to sync');
              emit(const _Error('No member data available'));
            }
          } catch (e) {
            log('Error syncing members to local database: $e');
            emit(_Error(e.toString()));
          }
        },
      );
    });
  }
}
