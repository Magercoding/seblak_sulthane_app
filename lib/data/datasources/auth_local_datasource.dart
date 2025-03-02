import 'package:seblak_sulthane_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = authResponseModel.toJson();
      await prefs.setString('auth_data', jsonData);
    } catch (e) {
      throw Exception('Failed to save auth data: $e');
    }
  }

  Future<void> removeAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove('auth_data');
    } catch (e) {
      throw Exception('Failed to remove auth data: $e');
    }
  }

  Future<AuthResponseModel> getAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authData = prefs.getString('auth_data');

      if (authData == null) {
        throw Exception('Auth data is null');
      }

      final model = AuthResponseModel.fromJson(authData);
      return model;
    } catch (e) {
      throw Exception('Failed to get auth data: $e');
    }
  }

  Future<bool> isAuthDataExists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final exists = prefs.containsKey('auth_data');

      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveSizeReceipt(String sizeReceipt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('size_receipt', sizeReceipt);
  }

  Future<String> getSizeReceipt() async {
    final prefs = await SharedPreferences.getInstance();
    final sizeReceipt = prefs.getString('size_receipt');
    return sizeReceipt ?? '';
  }
}
