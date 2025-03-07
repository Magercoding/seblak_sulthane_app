import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_repository%20.dart';
import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';

part 'discount_bloc.freezed.dart';
part 'discount_event.dart';
part 'discount_state.dart';

class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final DiscountRepository discountRepository;

  DiscountBloc(this.discountRepository) : super(const _Initial()) {
    on<_GetDiscounts>((event, emit) async {
      emit(const _Loading());
      final result = await discountRepository.getDiscounts();
      result.fold(
        (error) => emit(_Error(error)),
        (response) => emit(_Loaded(response.data ?? [])),
      );
    });

    on<_AddDiscount>((event, emit) async {
      if (event.name.isEmpty || event.value < 0 || event.value > 100) {
        emit(_Error('Nama diskon dan nilai diskon harus valid'));
        return;
      }
      emit(const _Loading());
      final result = await discountRepository.addDiscount(
        name: event.name,
        description: event.description,
        value: event.value,
        category: event.category,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (r) {
          emit(const _Success('Discount added successfully'));
          // Automatically refresh the discounts list
          add(const DiscountEvent.getDiscounts());
        },
      );
    });

    on<_UpdateDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await discountRepository.updateDiscount(
        id: event.id,
        name: event.name,
        description: event.description,
        value: event.value,
        category: event.category,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (r) {
          emit(const _Success('Discount updated successfully'));
          // Automatically refresh the discounts list
          add(const DiscountEvent.getDiscounts());
        },
      );
    });

    on<_DeleteDiscount>((event, emit) async {
      emit(const _Loading());
      final result = await discountRepository.deleteDiscount(event.id);
      result.fold(
        (error) => emit(_Error(error)),
        (r) {
          emit(const _Success('Discount deleted successfully'));
          // Automatically refresh the discounts list
          add(const DiscountEvent.getDiscounts());
        },
      );
    });

    on<_GetDiscountsByCategory>((event, emit) async {
      emit(const _Loading());
      final result =
          await discountRepository.getDiscountsByCategory(event.category);
      result.fold(
        (error) => emit(_Error(error)),
        (discounts) => emit(_Loaded(discounts)),
      );
    });
  }
}
