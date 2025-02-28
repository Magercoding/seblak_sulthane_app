import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/discount_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';

part 'sync_discount_bloc.freezed.dart';
part 'sync_discount_event.dart';
part 'sync_discount_state.dart';

class SyncDiscountBloc extends Bloc<SyncDiscountEvent, SyncDiscountState> {
  final DiscountRemoteDatasource discountRemoteDatasource;

  SyncDiscountBloc(
    this.discountRemoteDatasource,
  ) : super(const _Initial()) {
    on<_SyncDiscount>((event, emit) async {
      emit(const _Loading());
      log('Starting to sync discounts...');

      // Get discounts from the API
      final result = await discountRemoteDatasource.getDiscounts();

      return result.fold(
        (error) {
          log('Error fetching discounts: $error');
          emit(_Error(error));
        },
        (discountResponseModel) async {
          // Success, now we need to save to local database
          try {
            log('Successfully fetched discounts from API');
            
            // First delete all existing discounts
            await DiscountLocalDatasource.instance.deleteAllDiscounts();
            log('Deleted existing discounts from local database');

            // Then insert the new discounts
            if (discountResponseModel.data != null &&
                discountResponseModel.data!.isNotEmpty) {
              log('Inserting ${discountResponseModel.data!.length} discounts to local database');
              await DiscountLocalDatasource.instance.insertDiscounts(
                discountResponseModel.data!,
              );
              log('Discounts sync completed successfully');
              emit(_Loaded(discountResponseModel));
            } else {
              log('No discount data available to sync');
              emit(const _Error('No discount data available'));
            }
          } catch (e) {
            log('Error syncing discounts to local database: $e');
            emit(_Error(e.toString()));
          }
        },
      );
    });
  }
}