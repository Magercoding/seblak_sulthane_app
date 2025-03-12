import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/datasources/outlet_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/order_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/outlet_model.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  final String baseUrl = Variables.baseUrl;
  final OutletLocalDataSource outletLocalDataSource = OutletLocalDataSource();

  Future<bool> saveOrder(OrderModel orderModel) async {
    final authData = await AuthLocalDataSource().getAuthData();
    log("OrderModelSingle: $orderModel");
    log("OrderModel: ${orderModel.toJson()}");
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/save-order'),
      body: orderModel.toJson(),
      headers: {
        'Authorization': 'Bearer ${authData.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    log("Response: ${response.statusCode}");
    log("Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success' &&
            responseData['data'] != null &&
            responseData['data']['outlet'] != null) {
          final outletData = responseData['data']['outlet'];

          final outlet = OutletModel(
            id: outletData['id'],
            name: outletData['name'],
            address1: outletData['address1'],
            address2: outletData['address2'],
            phone: outletData['phone'],
            createdAt: outletData['created_at'] != null
                ? DateTime.parse(outletData['created_at'])
                : null,
            updatedAt: outletData['updated_at'] != null
                ? DateTime.parse(outletData['updated_at'])
                : null,
          );

          await outletLocalDataSource.saveOutlet(outlet);
          log("Outlet saved: ${outlet.toJson()}");
        }
      } catch (e) {
        log("Error extracting outlet data: $e");
      }

      return true;
    } else {
      return false;
    }
  }

  Future<Either<String, OrderResponseModel>> getOrderByRangeDate(
    String startDate,
    String endDate,
    int outletId,
  ) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final token = authData.token ?? '';

    final url = '$baseUrl/api/orders?start_date=$startDate&end_date=$endDate';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      log('Url: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final ordersData = responseData['data'] as List;

        final filteredOrders = ordersData
            .where((order) => order['outlet_id'] == outletId)
            .toList();

        if (filteredOrders.isEmpty) {
          return Left('No orders data for this outlet');
        }

        for (var order in filteredOrders) {
          if (order['outlet'] != null) {
            final outletData = order['outlet'];

            final outlet = OutletModel(
              id: outletData['id'],
              name: outletData['name'],
              address1: outletData['address1'],
              address2: outletData['address2'],
              phone: outletData['phone'],
              createdAt: outletData['created_at'] != null
                  ? DateTime.parse(outletData['created_at'])
                  : null,
              updatedAt: outletData['updated_at'] != null
                  ? DateTime.parse(outletData['updated_at'])
                  : null,
            );

            await outletLocalDataSource.saveOutlet(outlet);
          }
        }

        final mappedOrders =
            filteredOrders.map((order) => ItemOrder.fromMap(order)).toList();

        return Right(OrderResponseModel(
          status: responseData['status'],
          data: mappedOrders,
        ));
      } else {
        return Left('Failed to fetch orders data');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SummaryResponseModel>> getSummaryByRangeDate(
    String startDate,
    String endDate,
    int outletId,
  ) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final token = authData.token ?? '';

    // Menggunakan endpoint baru untuk summary
    final url =
        '$baseUrl/api/summary?start_date=$startDate&end_date=$endDate&outlet_id=$outletId';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      log('Url: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          return Right(SummaryResponseModel.fromJson(responseData));
        } catch (e) {
          log('Error parsing summary data: $e');
          return Left('Error processing data: $e');
        }
      } else {
        return Left('Failed to fetch summary data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching summary: $e');
      return Left(e.toString());
    }
  }
}
