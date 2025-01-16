import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:seblak_sulthane_app/data/datasources/discount_remote_datasource.dart';

part 'add_discount_bloc.freezed.dart';
part 'add_discount_event.dart';
part 'add_discount_state.dart';

class AddDiscountBloc extends Bloc<AddDiscountEvent, AddDiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;
  
  AddDiscountBloc(this.discountRemoteDatasource) : super(const _Initial()) {
    on<_AddDiscount>((event, emit) async {
      emit(const _Loading());
      
      final result = await discountRemoteDatasource.addDiscount(
        name: event.name,
        description: event.description,
        value: event.value,
        category: event.category,
      );

      result.fold(
        (error) => emit(_Error(error)),
        (response) => emit(const _Success()),
      );
    });
  }
}