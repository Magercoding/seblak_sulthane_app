// lib/presentation/setting/bloc/sync_category/sync_category_bloc.dart
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:seblak_sulthane_app/data/datasources/category_repository.dart';

part 'sync_category_bloc.freezed.dart';
part 'sync_category_event.dart';
part 'sync_category_state.dart';

class SyncCategoryBloc extends Bloc<SyncCategoryEvent, SyncCategoryState> {
  final CategoryRepository categoryRepository;

  SyncCategoryBloc(
    this.categoryRepository,
  ) : super(const _Initial()) {
    on<_SyncCategory>((event, emit) async {
      emit(const _Loading());
      log('Starting to sync categories...');

      // Check for connectivity first
      final isOnline = await categoryRepository.isConnected();

      if (!isOnline) {
        log('Device is offline, cannot sync categories');
        emit(const _Error('Device is offline, cannot sync categories'));
        return;
      }

      final result = await categoryRepository.getCategories();

      return result.fold(
        (error) {
          log('Error syncing categories: $error');
          emit(_Error(error));
        },
        (categoryResponseModel) {
          log('Categories sync completed successfully');
          emit(_Loaded(categoryResponseModel));
        },
      );
    });
  }
}
