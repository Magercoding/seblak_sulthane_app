import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/core/constants/variables.dart';
import 'package:seblak_sulthane_app/data/datasources/auth_local_datasource.dart';
import 'package:seblak_sulthane_app/data/models/response/item_sales_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/product_sales_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class OrderItemRemoteDatasource {
  final String baseUrl = Variables.baseUrl;
  
  Future<Either<String, ItemSalesResponseModel>> getItemSalesByRangeDate(
    String startDate,
    String endDate,
    int outletId,
  ) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final token = authData.token ?? ''; // Ensure it doesn't return null


    final url = '$baseUrl/api/order-item?start_date=$startDate&end_date=$endDate';
    final headers = {'Authorization': 'Bearer $token'};

    try {
      log('Url: $url');
      final response = await http.get(Uri.parse(url), headers: headers);
      log('Response: ${response.statusCode}');
      log('Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final itemsData = responseData['data'] as List;
        
        // Get orders to find outlet information
        final ordersResponse = await http.get(
          Uri.parse('$baseUrl/api/orders?start_date=$startDate&end_date=$endDate'),
          headers: headers,
        );
        
        if (ordersResponse.statusCode == 200) {
          final ordersData = jsonDecode(ordersResponse.body)['data'] as List;
          
          // Create a map of order ID to outlet ID for fast lookup
          final Map<int, int> orderOutletMap = {};
          for (var order in ordersData) {
            orderOutletMap[order['id']] = order['outlet_id'];
          }
          
          // Filter items by matching orders that belong to the specified outlet
          final filteredItems = itemsData.where((item) {
            final orderId = item['order_id'];
            return orderOutletMap.containsKey(orderId) && orderOutletMap[orderId] == outletId;
          }).toList();
          
          if (filteredItems.isEmpty) {
            return Left('No item sales data for this outlet');
          }
          
          // Map the filtered data to ItemSales objects with outlet ID
          final mappedItems = filteredItems.map((item) => 
            ItemSales(
              id: item['id'],
              orderId: item['order_id'],
              productId: item['product_id'],
              quantity: item['quantity'],
              price: item['price'],
              createdAt: item['created_at'],
              updatedAt: item['updated_at'],
              productName: item['product_name'],
              outletId: outletId,
            )
          ).toList();
          
          return Right(ItemSalesResponseModel(
            status: responseData['status'],
            data: mappedItems,
          ));
        }
        
        return Left('Failed to fetch orders data for filtering');
      } else {
        return Left('Failed to fetch item sales data');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductSalesResponseModel>> getProductSalesByRangeDate(
    String startDate,
    String endDate,
    int outletId,
  ) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final token = authData.token ?? ''; // Ensure it doesn't return null


    try {
      // We need both order items and orders data for proper filtering
      final itemsUrl = '$baseUrl/api/order-item?start_date=$startDate&end_date=$endDate';
      final ordersUrl = '$baseUrl/api/orders?start_date=$startDate&end_date=$endDate';
      final headers = {'Authorization': 'Bearer $token'};
      
      // Make parallel requests for better performance
      final itemsFuture = http.get(Uri.parse(itemsUrl), headers: headers);
      final ordersFuture = http.get(Uri.parse(ordersUrl), headers: headers);
      
      final responses = await Future.wait([itemsFuture, ordersFuture]);
      final itemsResponse = responses[0];
      final ordersResponse = responses[1];
      
      if (itemsResponse.statusCode == 200 && ordersResponse.statusCode == 200) {
        final itemsData = jsonDecode(itemsResponse.body)['data'] as List;
        final ordersData = jsonDecode(ordersResponse.body)['data'] as List;
        
        // Create a map of order ID to outlet ID for fast lookup
        final Map<int, int> orderOutletMap = {};
        for (var order in ordersData) {
          orderOutletMap[order['id']] = order['outlet_id'];
        }
        
        // Filter items by matching orders that belong to the specified outlet
        final filteredItems = itemsData.where((item) {
          final orderId = item['order_id'];
          return orderOutletMap.containsKey(orderId) && orderOutletMap[orderId] == outletId;
        }).toList();
        
        if (filteredItems.isEmpty) {
          return Left('No product sales data for this outlet');
        }
        
        // Create a map of product ID to aggregated quantities
        final Map<int, Map<String, dynamic>> productMap = {};
        
        for (var item in filteredItems) {
          final productId = item['product_id'];
          final productName = item['product_name'];
          final quantity = item['quantity'];
          
          if (!productMap.containsKey(productId)) {
            productMap[productId] = {
              'product_id': productId,
              'product_name': productName,
              'total_quantity': 0,
            };
          }
          
          productMap[productId]!['total_quantity'] += quantity;
        }
        
        // Convert the aggregated data to ProductSales objects
        final mappedProducts = productMap.values.map((product) => 
          ProductSales(
            productId: product['product_id'],
            productName: product['product_name'],
            totalQuantity: product['total_quantity'].toString(),
            outletId: outletId,
          )
        ).toList();
        
        return Right(ProductSalesResponseModel(
          status: 'success',
          data: mappedProducts,
        ));
      } else {
        return Left('Failed to fetch data for product sales');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}