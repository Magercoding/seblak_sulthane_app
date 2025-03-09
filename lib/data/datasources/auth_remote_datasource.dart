import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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

      debugPrint('Login response status: ${response.statusCode}');
      debugPrint('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        final authModel = AuthResponseModel.fromJson(response.body);

        // After successful login, immediately get and save the user profile
        // Add null check for token
        if (authModel.token != null) {
          await _fetchAndSaveUserProfile(authModel.token!);
        } else {
          debugPrint('Token is null after login. Skipping profile fetch.');
        }

        return Right(authModel);
      } else {
        return Left('Failed to login: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      return Left('Error during login: $e');
    }
  }

  // Helper method to fetch and save user profile after login
  Future<void> _fetchAndSaveUserProfile(String token) async {
    try {
      final url = Uri.parse('${Variables.baseUrl}/api/user');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
      );

      if (response.statusCode == 200) {
        final userModel = UserModel.fromJson(json.decode(response.body));

        // Save to local data source
        final authLocalDataSource = AuthLocalDataSource();
        await authLocalDataSource.saveUserData(userModel);

        debugPrint('User profile saved to local storage: ${userModel.name}');
      } else {
        debugPrint(
            'Failed to fetch user profile after login: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching user profile after login: $e');
    }
  }

  Future<Either<String, bool>> logout() async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();

      // Check if token is null
      if (authData.token == null) {
        debugPrint(
            'Token is null, cannot make logout API request. Removing local auth data.');
        await AuthLocalDataSource().removeAuthData();
        return const Right(true);
      }

      final url = Uri.parse('${Variables.baseUrl}/api/logout');
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token!}',
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
      debugPrint('Error during logout, still removing auth data: $e');
      await AuthLocalDataSource().removeAuthData();
      return const Right(true);
    }
  }

  Future<Either<String, UserModel>> getProfile() async {
    try {
      debugPrint('Attempting to get user profile from API');
      final authData = await AuthLocalDataSource().getAuthData();

      // Check if token is null
      if (authData.token == null) {
        debugPrint('Token is null, cannot make API request');
        // Try to get from local storage as fallback
        return await _getProfileFromLocal('Token is null');
      }

      final url = Uri.parse('${Variables.baseUrl}/api/user');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token!}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
      );

      debugPrint('Profile API response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('Profile API response body: ${response.body}');
        final userModel = UserModel.fromJson(json.decode(response.body));

        // Save profile to local storage for offline access
        final authLocalDataSource = AuthLocalDataSource();
        await authLocalDataSource.saveUserData(userModel);
        debugPrint(
            'User profile saved to local storage from API: ${userModel.name}');

        return Right(userModel);
      } else {
        debugPrint('Failed to get profile API: ${response.body}');
        return await _getProfileFromLocal(
            'API request failed with status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error during get profile from API: $e');
      return await _getProfileFromLocal('API error: $e');
    }
  }

  // Helper method to get profile from local storage with consistent error handling
  Future<Either<String, UserModel>> _getProfileFromLocal(String reason) async {
    try {
      debugPrint('Trying to get profile from local storage: $reason');
      final authLocalDataSource = AuthLocalDataSource();
      final userData = await authLocalDataSource.getUserData();
      debugPrint('Found local profile data: ${userData.name}');
      return Right(userData);
    } catch (localError) {
      debugPrint('No local profile data available: $localError');
      return Left('Failed to get profile: $reason, Local error: $localError');
    }
  }
}
