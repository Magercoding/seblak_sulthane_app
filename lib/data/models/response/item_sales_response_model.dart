
class ItemSalesResponseModel {
  final String? status;
  final List<ItemSales>? data;

  const ItemSalesResponseModel({
    this.status,
    this.data,
  });

  factory ItemSalesResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemSalesResponseModel(
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((itemJson) => ItemSales.fromJson(itemJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((item) => item.toJson()).toList(),
      };
}

class ItemSales {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final int price;
  final String createdAt;
  final String updatedAt;
  final String productName;
  final int outletId;
  String? categoryName; // New field for category name

  ItemSales({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.productName,
    required this.outletId,
    this.categoryName,
  });

  factory ItemSales.fromJson(Map<String, dynamic> json) {
    return ItemSales(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productName: json['product_name'],
      outletId: json['outlet_id'] ?? 0,
      categoryName: json['category_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_id': orderId,
        'product_id': productId,
        'quantity': quantity,
        'price': price,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'product_name': productName,
        'outlet_id': outletId,
        'category_name': categoryName,
      };

  // Create a copy of this instance with optional changes
  ItemSales copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? quantity,
    int? price,
    String? createdAt,
    String? updatedAt,
    String? productName,
    int? outletId,
    String? categoryName,
  }) {
    return ItemSales(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productName: productName ?? this.productName,
      outletId: outletId ?? this.outletId,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}
