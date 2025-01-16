import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    try {
      final url = Uri.parse('${Variables.baseUrl}/api/login');
      print('Login request to: $url');

      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );

      print('Login status code: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final authModel = AuthResponseModel.fromJson(response.body);
        print('Login successful - Token: ${authModel.token}');
        return Right(authModel);
      } else {
        print('Login failed with status: ${response.statusCode}');
        return Left('Failed to login: ${response.body}');
      }
    } catch (e) {
      print('Login error: $e');
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
          'X-Requested-With': 'XMLHttpRequest' // Tambahan untuk Sanctum
        },
      );

      // Jika dapat 401, tetap anggap sukses karena kita mau logout
      if (response.statusCode == 200 || response.statusCode == 401) {
        await AuthLocalDataSource().removeAuthData(); // Hapus token lokal
        return const Right(true); // Anggap sukses
      } else {
        return Left('Failed to logout: ${response.body}');
      }
    } catch (e) {
      // Jika error, tetap coba hapus token lokal
      await AuthLocalDataSource().removeAuthData();
      return const Right(
          true); // Tetap anggap sukses karena token sudah dihapus
    }
  }
}
