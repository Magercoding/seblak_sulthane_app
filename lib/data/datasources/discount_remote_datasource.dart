import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/discount_response_model.dart';
import 'package:http/http.dart' as http;

class DiscountRemoteDatasource {
  Future<Either<String, DiscountResponseModel>> getDiscounts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/discounts');
    final authData = await AuthLocalDataSource().getAuthData();

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Right(DiscountResponseModel.fromRawJson(response.body));
      } else {
        return Left('Failed to get discounts: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, DiscountResponseModel>> addDiscount({
    required String name,
    required String description,
    required int value,
    required String category,
  }) async {
    final url = Uri.parse('${Variables.baseUrl}/api/discounts');
    final authData = await AuthLocalDataSource().getAuthData();

    try {
      // Convert value to string before sending
      final Map<String, dynamic> body = {
        'name': name,
        'description': description,
        'value': value.toString(),
        'type': 'percentage',
        'category': category,
      };

      print('Request body: ${jsonEncode(body)}'); // Debug print

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${authData.token}',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print

      if (response.statusCode == 201) {
        return Right(DiscountResponseModel.fromRawJson(response.body));
      } else {
        return Left(
            'Failed to add discount: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      return Left('Error: $e');
    }
  }
}
