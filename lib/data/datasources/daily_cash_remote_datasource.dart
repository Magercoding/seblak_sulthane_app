import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/daily_cash_model.dart';

class DailyCashRemoteDatasource {
  static Map<String, String> openingBalanceTimestamps = {};

  final String baseUrl = Variables.baseUrl;

  Future<Either<String, DailyCashResponse>> setOpeningBalance(
    String date,
    int openingBalance,
  ) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';

      final url = '$baseUrl/api/daily-cash/opening';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'date': date,
        'opening_balance': openingBalance,
      });

      log('Setting opening balance: $url');
      log('Body: $body');

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final responseData = jsonDecode(response.body);

          // Store the created_at timestamp if available
          if (responseData['data'] != null &&
              responseData['data']['created_at'] != null) {
            openingBalanceTimestamps[date] = responseData['data']['created_at'];
            print(
                "DEBUG: Stored timestamp for $date: ${openingBalanceTimestamps[date]}");
          }

          return Right(DailyCashResponse.fromMap(responseData));
        } catch (parseError) {
          return Left('Gagal memproses respons: $parseError');
        }
      } else {
        return Left('Gagal menyimpan saldo awal: ${response.body}');
      }
    } catch (e) {
      log('Error setting opening balance: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, DailyCashResponse>> addExpense(
    String date,
    int amount,
    String note,
  ) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';

      final url = '$baseUrl/api/daily-cash/expense';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'date': date,
        'amount': amount,
        'note': note,
      });

      log('Adding expense: $url');
      log('Body: $body');

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final responseData = jsonDecode(response.body);
          return Right(DailyCashResponse.fromMap(responseData));
        } catch (parseError) {
          log('Error parsing response: $parseError');
          return Left('Gagal memproses respons: $parseError');
        }
      } else {
        return Left('Gagal menambahkan pengeluaran: ${response.body}');
      }
    } catch (e) {
      log('Error adding expense: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, DailyCashResponse>> getDailyCash(String date) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';

      final url = '$baseUrl/api/daily-cash/$date';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      log('Fetching daily cash: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          final apiResponse = DailyCashResponse.fromMap(responseData);

          // Inject the stored timestamp into the response if available
          if (openingBalanceTimestamps.containsKey(date) &&
              responseData['data'] != null) {
            // Create a modified data object with the timestamp
            Map<String, dynamic> modifiedData = Map.from(responseData['data']);
            modifiedData['created_at'] = openingBalanceTimestamps[date];

            // Replace the response data with the modified data
            final modifiedResponse = {
              'status': responseData['status'],
              'message': responseData['message'],
              'data': modifiedData
            };

            return Right(DailyCashResponse.fromMap(modifiedResponse));
          }

          return Right(apiResponse);
        } catch (parseError) {
          log('Error parsing daily cash response: $parseError');
          final errorMessage = parseError.toString().contains('String') &&
                  parseError.toString().contains('int')
              ? 'Terjadi kesalahan format data dari server'
              : 'Gagal memproses respons: $parseError';
          return Left(errorMessage);
        }
      } else {
        if (response.statusCode == 404) {
          return Left('Data kas untuk tanggal ini tidak ditemukan');
        }
        return Left('Gagal mengambil data kas: ${response.body}');
      }
    } catch (e) {
      log('Error getting daily cash: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }

  // Helper method to format date in YYYY-MM-DD format
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Helper to get today's date in YYYY-MM-DD format
  String getTodayDate() {
    return formatDate(DateTime.now());
  }
}
