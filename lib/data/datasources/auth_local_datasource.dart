import 'dart:convert';

import 'package:seblak_sulthane_app/data/models/response/auth_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  // Auth data methods
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

  // User profile methods
  Future<void> saveUserData(UserModel userModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = json.encode(userModel.toMap());
      print(
          "Saving to SharedPreferences with key 'user_data': ${userModel.name}");
      final result = await prefs.setString('user_data', jsonData);
      print("Save result: $result");

      // Verify the data was saved correctly
      final checkData = prefs.getString('user_data');
      if (checkData != null) {
        final Map<String, dynamic> checkMap = json.decode(checkData);
        print("Verified saved data name: ${checkMap['name']}");
      } else {
        print("WARNING: Verification failed - data not found after saving");
      }
    } catch (e) {
      print('Detailed error saving user data: $e');
      throw Exception('Failed to save user data: $e');
    }
  }

  Future<UserModel> getUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString('user_data');
      print(
          "Retrieved from SharedPreferences with key 'user_data': ${userData != null ? 'data found' : 'NULL'}");

      if (userData == null) {
        print("No user data found in local storage");
        throw Exception('User data is null');
      }

      try {
        final userMap = json.decode(userData) as Map<String, dynamic>;
        print(
            "Parsed user data: name=${userMap['name']}, role=${userMap['role']}");
        final model = UserModel.fromMap(userMap);
        print("Successfully created UserModel with name: ${model.name}");
        return model;
      } catch (parseError) {
        print("ERROR parsing user data: $parseError");
        print("Raw user data from storage: $userData");
        throw Exception('Failed to parse user data: $parseError');
      }
    } catch (e) {
      print("Detailed error getting user data: $e");
      throw Exception('Failed to get user data: $e');
    }
  }

  Future<String> getUserName() async {
    try {
      final userData = await getUserData();
      return userData.name;
    } catch (e) {
      // Return a default name if user data is not available
      return "Cashier";
    }
  }

  Future<bool> isUserDataExists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final exists = prefs.containsKey('user_data');
      return exists;
    } catch (e) {
      return false;
    }
  }

  // Receipt size methods
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
