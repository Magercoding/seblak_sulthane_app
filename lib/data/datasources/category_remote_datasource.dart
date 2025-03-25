import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/category_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  final CategoryLocalDatasource localDatasource = CategoryLocalDatasource();

  Future<Either<String, CategoryResponseModel>> getCategories() async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final Map<String, String> headers = {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
      };

      final response = await http.get(
          Uri.parse('${Variables.baseUrl}/api/categories'),
          headers: headers);

      log(response.statusCode.toString());
      log(response.body);

      if (response.statusCode == 200) {
        final categoryResponse = CategoryResponseModel.fromJson(response.body);
        // Save to local storage for offline use
        await localDatasource.saveCategories(categoryResponse.data);
        return right(categoryResponse);
      } else {
        // Try to get from local storage if API call fails
        final localCategories = await localDatasource.getCategories();
        if (localCategories.isNotEmpty) {
          return right(CategoryResponseModel(
            status: 'success',
            data: localCategories,
          ));
        }
        return left(response.body);
      }
    } catch (e) {
      // Try to get from local storage if there's any error
      final localCategories = await localDatasource.getCategories();
      if (localCategories.isNotEmpty) {
        return right(CategoryResponseModel(
          status: 'success',
          data: localCategories,
        ));
      }
      return left(e.toString());
    }
  }
}
