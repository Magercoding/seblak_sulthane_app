import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/discount_remote_datasource.dart';
import '../../../../data/models/response/discount_response_model.dart';

part 'discount_bloc.freezed.dart';
part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;

  DiscountBloc(this.discountRemoteDatasource) : super(const _Initial()) {
    on<_GetDiscounts>((event, emit) async {
      emit(const _Loading());
      final result = await discountRemoteDatasource.getDiscounts();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });

    on<_AddDiscount>((event, emit) async {
      if (event.name.isEmpty || event.value < 0 || event.value > 100) {
        emit(_Error('Nama diskon dan nilai diskon harus valid'));
        return;
      }
      emit(const _Loading());
      final result = await discountRemoteDatasource.addDiscount(
        name: event.name,
        description: event.description,
        value: event.value,
        category: event.category,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success('Discount added successfully')),
      );
    });

    on<_UpdateDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await discountRemoteDatasource.updateDiscount(
        id: event.id,
        name: event.name,
        description: event.description,
        value: event.value,
        category: event.category,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success('Discount updated successfully')),
      );
    });

    on<_DeleteDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await discountRemoteDatasource.deleteDiscount(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success('Discount deleted successfully')),
      );
    });
  }
}
