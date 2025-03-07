import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_repository%20.dart';
import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';

part 'sync_discount_bloc.freezed.dart';
part 'sync_discount_event.dart';
part 'sync_discount_state.dart';

class SyncDiscountBloc extends Bloc<SyncDiscountEvent, SyncDiscountState> {
  final DiscountRepository discountRepository;

  SyncDiscountBloc(
    this.discountRepository,
  ) : super(const _Initial()) {
    on<_SyncDiscount>((event, emit) async {
      emit(const _Loading());
      log('Starting to sync discounts...');

      // Check for connectivity first
      final isOnline = await discountRepository.isConnected();

      if (!isOnline) {
        log('Device is offline, cannot sync discounts');
        emit(const _Error('Device is offline, cannot sync discounts'));
        return;
      }

      final result = await discountRepository.getDiscounts();

      return result.fold(
        (error) {
          log('Error syncing discounts: $error');
          emit(_Error(error));
        },
        (discountResponseModel) {
          log('Discounts sync completed successfully');
          emit(_Loaded(discountResponseModel));
        },
      );
    });
  }
}
