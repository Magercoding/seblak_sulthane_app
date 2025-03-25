// lib/presentation/home/bloc/get_categories/get_categories_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:seblak_sulthane_app/data/datasources/category_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/category_repository.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';
part 'get_categories_bloc.freezed.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final CategoryRepository repository;

  GetCategoriesBloc(this.repository) : super(const _Initial()) {
    on<_GetCategories>((event, emit) async {
      emit(const _Loading());

      final result = await repository.getCategories();

      result.fold((error) => emit(_Error(error)),
          (categoryResponseModel) => emit(_Loaded(categoryResponseModel)));
    });
  }
}
