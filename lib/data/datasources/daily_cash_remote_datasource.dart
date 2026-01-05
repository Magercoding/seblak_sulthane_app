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
      final user = authData.user;

      // Check if user has outlet_id
      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat mengatur saldo awal.');
      }

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
        // Handle error response from backend
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Gagal menyimpan saldo awal';
          return Left(errorMessage);
        } catch (_) {
          return Left('Gagal menyimpan saldo awal: ${response.body}');
        }
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
      final user = authData.user;

      // Check if user has outlet_id
      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat menambahkan pengeluaran.');
      }

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
        // Handle error response from backend
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Gagal menambahkan pengeluaran';
          return Left(errorMessage);
        } catch (_) {
          return Left('Gagal menambahkan pengeluaran: ${response.body}');
        }
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
      final user = authData.user;

      // Check if user has outlet_id
      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat melihat data kas harian.');
      }

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
          
          // Pastikan responseData adalah Map
          if (responseData is! Map<String, dynamic>) {
            return Left('Format response tidak valid dari server');
          }
          
          final apiResponse = DailyCashResponse.fromMap(responseData);
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
        // Handle error response from backend
        if (response.statusCode == 403 || response.statusCode == 404) {
          try {
            final errorData = jsonDecode(response.body);
            final errorMessage = errorData['message'] ??
                'Akses ditolak atau data tidak ditemukan';
            return Left(errorMessage);
          } catch (_) {
            return Left('Akses ditolak atau data tidak ditemukan');
          }
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

  Future<Either<String, DailyCashResponse>> openShift(
    String date,
    int openingBalance, {
    String? shiftName,
  }) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';
      final user = authData.user;

      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat membuka shift.');
      }

      final url = '$baseUrl/api/daily-cash/open';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'date': date,
        'opening_balance': openingBalance,
        if (shiftName != null) 'shift_name': shiftName,
      });

      log('Opening shift: $url');
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
          return Left('Gagal memproses respons: $parseError');
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Gagal membuka shift';
          return Left(errorMessage);
        } catch (_) {
          return Left('Gagal membuka shift: ${response.body}');
        }
      }
    } catch (e) {
      log('Error opening shift: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, DailyCashResponse>> closeShift(int shiftId) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';
      final user = authData.user;

      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat menutup shift.');
      }

      final url = '$baseUrl/api/daily-cash/close';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'shift_id': shiftId,
      });

      log('Closing shift: $url');
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
          return Left('Gagal memproses respons: $parseError');
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Gagal menutup shift';
          return Left(errorMessage);
        } catch (_) {
          return Left('Gagal menutup shift: ${response.body}');
        }
      }
    } catch (e) {
      log('Error closing shift: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, DailyCashResponse>> getActiveShifts() async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';
      final user = authData.user;

      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat melihat shift aktif.');
      }

      final url = '$baseUrl/api/daily-cash/active';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      log('Fetching active shifts: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          return Right(DailyCashResponse.fromMap(responseData));
        } catch (parseError) {
          return Left('Gagal memproses respons: $parseError');
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Gagal mengambil shift aktif';
          return Left(errorMessage);
        } catch (_) {
          return Left('Gagal mengambil shift aktif: ${response.body}');
        }
      }
    } catch (e) {
      log('Error getting active shifts: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }

  Future<Either<String, DailyCashResponse>> fetchShiftById(int shiftId) async {
    try {
      final authData = await AuthLocalDataSource().getAuthData();
      final token = authData.token ?? '';
      final user = authData.user;

      if (user?.outletId == null) {
        return Left(
            'User tidak memiliki outlet. Hanya admin dan staff yang dapat melihat shift.');
      }

      final url = '$baseUrl/api/daily-cash?shift_id=$shiftId';
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      log('Fetching shift by ID: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          return Right(DailyCashResponse.fromMap(responseData));
        } catch (parseError) {
          return Left('Gagal memproses respons: $parseError');
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Gagal mengambil shift';
          return Left(errorMessage);
        } catch (_) {
          return Left('Gagal mengambil shift: ${response.body}');
        }
      }
    } catch (e) {
      log('Error fetching shift by ID: $e');
      return Left('Terjadi kesalahan: $e');
    }
  }
}
