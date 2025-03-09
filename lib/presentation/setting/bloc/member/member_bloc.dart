import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/models/response/member_response_model.dart';
import 'package:seblak_sulthane_app/data/datasources/member_repository.dart';

part 'member_bloc.freezed.dart';
part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberRepository memberRepository;

  MemberBloc(this.memberRepository) : super(const _Initial()) {
    on<_GetMembers>((event, emit) async {
      emit(const _Loading());
      final result = await memberRepository.getMembers();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.data)),
      );
    });

    on<_SearchMembers>((event, emit) async {
      if (event.query.isEmpty) {
        // If query is empty, just get all members
        add(const MemberEvent.getMembers());
        return;
      }

      emit(const _Loading());
      final result = await memberRepository.searchMembers(event.query);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.data)),
      );
    });

    on<_AddMember>((event, emit) async {
      emit(const _Loading());
      final result = await memberRepository.addMember(
        name: event.name,
        phone: event.phone,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(const _Success('Berhasil menambahkan member'));
          // Automatically refresh the members list
          add(const MemberEvent.getMembers());
        },
      );
    });

    on<_UpdateMember>((event, emit) async {
      emit(const _Loading());
      final result = await memberRepository.updateMember(
        id: event.id,
        name: event.name,
        phone: event.phone,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(const _Success('Berhasil mengupdate member'));
          // Automatically refresh the members list
          add(const MemberEvent.getMembers());
        },
      );
    });

    on<_DeleteMember>((event, emit) async {
      emit(const _Loading());
      final result = await memberRepository.deleteMember(event.id);
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(const _Success('Berhasil menghapus member'));
          // Automatically refresh the members list
          add(const MemberEvent.getMembers());
        },
      );
    });

    on<_GetMemberByPhone>((event, emit) async {
      emit(const _Loading());
      final result = await memberRepository.getMemberByPhone(event.phone);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data.data)),
      );
    });
  }
}
