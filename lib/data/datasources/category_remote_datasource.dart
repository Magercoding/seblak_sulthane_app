import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<Either<String, CategroyResponseModel>> getCategories() async {
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
      return right(CategroyResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
