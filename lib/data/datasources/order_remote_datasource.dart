import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/order_remote_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/summary_response_model.dart';
import 'package:seblak_sulthane_app/presentation/home/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  final String baseUrl = Variables.baseUrl;

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
    final token = authData.token ?? ''; // Ensure it doesn't return null

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

        // Filter orders by outlet_id
        final filteredOrders = ordersData
            .where((order) => order['outlet_id'] == outletId)
            .toList();

        if (filteredOrders.isEmpty) {
          return Left('No orders data for this outlet');
        }

        // Map the filtered data to ItemOrder objects
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
    final token = authData.token ?? ''; // Ensure it doesn't return null

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

        // Filter orders by outlet_id
        final filteredOrders = ordersData
            .where((order) => order['outlet_id'] == outletId)
            .toList();

        if (filteredOrders.isEmpty) {
          return Left('No summary data for this outlet');
        }

        // Calculate summary based on filtered orders
        double totalRevenue = 0;
        double totalDiscount = 0;
        double totalTax = 0;
        double totalSubtotal = 0;
        double totalServiceCharge = 0;
        double total = 0;

        for (var order in filteredOrders) {
          totalRevenue += (order['payment_amount'] ?? 0).toDouble();
          totalDiscount +=
              double.tryParse(order['discount_amount']?.toString() ?? '0') ?? 0;
          totalTax += (order['tax'] ?? 0).toDouble();
          totalSubtotal += (order['sub_total'] ?? 0).toDouble();
          totalServiceCharge += (order['service_charge'] ?? 0).toDouble();
          total += (order['total'] ?? 0).toDouble();
        }

        final summaryData = SummaryData(
          totalRevenue: totalRevenue.toString(),
          totalDiscount: totalDiscount.toStringAsFixed(2),
          totalTax: totalTax.toString(),
          totalSubtotal: totalSubtotal.toString(),
          totalServiceCharge: totalServiceCharge,
          total: total.round(),
          outletId: outletId, // Add outletId for reference
        );

        return Right(SummaryResponseModel(
          status: 'success',
          data: summaryData,
        ));
      } else {
        return Left('Failed to fetch summary data');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
