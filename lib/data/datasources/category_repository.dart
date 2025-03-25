// lib/data/datasources/category_repository.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/data/datasources/category_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/category_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';

class CategoryRepository {
  final CategoryRemoteDatasource remoteDatasource;
  final CategoryLocalDatasource localDatasource;
  final Connectivity connectivity;

  CategoryRepository({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.connectivity,
  });

  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<Either<String, CategoryResponseModel>> getCategories() async {
    try {
      final result = await remoteDatasource.getCategories();

      // Use fold to handle the Either result
      return result.fold((error) => Left(error), (categoryResponseModel) async {
        // Save categories to local datasource
        await localDatasource.saveCategories(categoryResponseModel.data);
        return Right(categoryResponseModel);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<CategoryModel>>> getLocalCategories() async {
    try {
      final categories = await localDatasource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
