import 'package:seblak_sulthane_app/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  Future<void> saveAuthData(AuthResponseModel authResponseModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = authResponseModel.toJson();
      print('Saving auth data: $jsonData');
      await prefs.setString('auth_data', jsonData);

      // Verifikasi data tersimpan
      final savedData = prefs.getString('auth_data');
      print('Verified saved auth data: $savedData');
    } catch (e) {
      print('Error saving auth data: $e');
      throw Exception('Failed to save auth data: $e');
    }
  }

  Future<void> removeAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final beforeRemove = prefs.getString('auth_data');
      print('Auth data before removal: $beforeRemove');

      await prefs.remove('auth_data');

      // Verifikasi data terhapus
      final afterRemove = prefs.getString('auth_data');
      print('Auth data after removal: $afterRemove');
    } catch (e) {
      print('Error removing auth data: $e');
      throw Exception('Failed to remove auth data: $e');
    }
  }

  Future<AuthResponseModel> getAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final authData = prefs.getString('auth_data');
      print('Retrieved auth data: $authData');

      if (authData == null) {
        throw Exception('Auth data is null');
      }

      final model = AuthResponseModel.fromJson(authData);
      print('Parsed auth model - Token: ${model.token}');
      return model;
    } catch (e) {
      print('Error getting auth data: $e');
      throw Exception('Failed to get auth data: $e');
    }
  }

  Future<bool> isAuthDataExists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final exists = prefs.containsKey('auth_data');
      print('Auth data exists: $exists');

      if (exists) {
        // Jika ada, cek juga isi datanya
        final data = prefs.getString('auth_data');
        print('Existing auth data: $data');
      }

      return exists;
    } catch (e) {
      print('Error checking auth data existence: $e');
      return false;
    }
  }

  // Midtrans dan Receipt methods tetap sama
  Future<void> saveMidtransServerKey(String serverKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('server_key', serverKey);
  }

  Future<String> getMitransServerKey() async {
    final prefs = await SharedPreferences.getInstance();
    final serverKey = prefs.getString('server_key');
    return serverKey ?? '';
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
