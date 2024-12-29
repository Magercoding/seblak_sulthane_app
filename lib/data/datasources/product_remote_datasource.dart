import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:seblak_sulthane_app/data/models/request/product_request_model.dart';
import 'package:seblak_sulthane_app/data/models/response/add_product_response_model.dart';
import 'package:seblak_sulthane_app/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/variables.dart';
import 'auth_local_datasource.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final url = Uri.parse('${Variables.baseUrl}/api/products');
    final authData = await AuthLocalDataSource().getAuthData();
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${authData.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Failed to get products');
    }
  }

  Future<Either<String, AddProductResponseModel>> addProduct(
      ProductRequestModel productRequestModel) async {
    final authData = await AuthLocalDataSource().getAuthData();
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.token}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/products'));
    request.fields.addAll(productRequestModel.toMap());
    request.files.add(await http.MultipartFile.fromPath(
        'image', productRequestModel.image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();
    log(response.stream.toString());
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
