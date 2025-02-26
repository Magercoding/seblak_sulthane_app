import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/member_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';

part 'member_bloc.freezed.dart';
part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberRemoteDatasource memberRemoteDatasource;

  MemberBloc(this.memberRemoteDatasource) : super(const _Initial()) {
    on<_GetMembers>((event, emit) async {
      emit(const _Loading());
      final result = await memberRemoteDatasource.getMembers();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.data)),
      );
    });

    on<_AddMember>((event, emit) async {
      emit(const _Loading());
      final result = await memberRemoteDatasource.addMember(
        name: event.name,
        phone: event.phone,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(const _Success('Berhasil menambahkan member')),
      );
    });

    on<_UpdateMember>((event, emit) async {
      emit(const _Loading());
      final result = await memberRemoteDatasource.updateMember(
        id: event.id,
        name: event.name,
        phone: event.phone,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(const _Success('Berhasil mengupdate member')),
      );
    });

    on<_DeleteMember>((event, emit) async {
      emit(const _Loading());
      final result = await memberRemoteDatasource.deleteMember(event.id);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(const _Success('Berhasil menghapus member')),
      );
    });
  }
}
