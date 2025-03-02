import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:seblak_sulthane_app/data/models/response/user_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    try {
      final url = Uri.parse('${Variables.baseUrl}/api/login');

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final authModel = AuthResponseModel.fromJson(response.body);
        return Right(authModel);
      } else {
        return Left('Failed to login: ${response.body}');
      }
    } catch (e) {
      return Left('Error during login: $e');
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final url = Uri.parse('${Variables.baseUrl}/api/logout');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest'
        },
      );

      if (response.statusCode == 200 || response.statusCode == 401) {
        await AuthLocalDataSource().removeAuthData();
        return const Right(true);
      } else {
        return Left('Failed to logout: ${response.body}');
      }
    } catch (e) {
      await AuthLocalDataSource().removeAuthData();
      return const Right(true);
    }
  }

  Future<Either<String, UserModel>> getProfile() async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final url = Uri.parse('${Variables.baseUrl}/api/user');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(json.decode(response.body));
        return Right(userModel);
      } else {
        return Left('Failed to get profile: ${response.body}');
      }
    } catch (e) {
      return Left('Error during get profile: $e');
    }
  }
}
