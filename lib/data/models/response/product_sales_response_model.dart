import 'dart:convert';

class ProductSalesResponseModel {
  final String? status;
  final List<ProductSales>? data;

  const ProductSalesResponseModel({
    this.status,
    this.data,
  });

  factory ProductSalesResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductSalesResponseModel(
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((productJson) => ProductSales.fromJson(productJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((product) => product.toJson()).toList(),
      };
}

class ProductSales {
  final int productId;
  final String productName;
  final String totalQuantity;
  final int outletId;

  const ProductSales({
    required this.productId,
    required this.productName,
    required this.totalQuantity,
    required this.outletId,
  });

  factory ProductSales.fromJson(Map<String, dynamic> json) {
    return ProductSales(
      productId: json['product_id'],
      productName: json['product_name'],
      totalQuantity: json['total_quantity'],
      outletId: json['outlet_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'total_quantity': totalQuantity,
        'outlet_id': outletId,
      };
}
