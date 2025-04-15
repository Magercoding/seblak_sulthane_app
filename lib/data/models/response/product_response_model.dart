import 'dart:convert';

import 'package:seblak_sulthane_app/presentation/home/pages/confirm_payment_page.dart';

class ProductResponseModel {
  final String? status;
  final List<Product>? data;

  ProductResponseModel({
    this.status,
    this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Product>.from(json["data"]!.map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Product {
  final int? id;
  final int? productId;
  final int? categoryId;
  final String? name;
  final String? description;
  final String? image;
  final String? price;
  final int? stock;
  final int? status;
  final int? isFavorite;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Category? category;

  Product({
    this.id,
    this.productId,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.price,
    this.stock,
    this.status,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        categoryId: json["category_id"] is String
            ? int.parse(json["category_id"])
            : json["category_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"].toString().replaceAll('.00', ''),
        stock: json["stock"],
        status: json["status"],
        isFavorite: json["is_favorite"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
      );

  factory Product.fromOrderMap(Map<String, dynamic> json) => Product(
        id: json["id_product"],
        price: json["price"].toString(),
      );

  factory Product.fromLocalMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        categoryId: json["categoryId"],
        category: Category(
          id: json["categoryId"],
          name: json["categoryName"],
        ),
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        status: json["status"],
        isFavorite: json["isFavorite"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toLocalMap() => {
        "product_id": id,
        "categoryId": categoryId,
        "categoryName": category?.name,
        "name": name,
        "description": description,
        "image": image,
        "price": price?.replaceAll(RegExp(r'\.0+$'), ''),
        "stock": stock,
        "status": status,
        "isFavorite": isFavorite,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "product_id": productId,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "status": status,
        "is_favorite": isFavorite,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toMap(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.productId == productId &&
        other.categoryId == categoryId &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.stock == stock &&
        other.status == status &&
        other.isFavorite == isFavorite &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        categoryId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        stock.hashCode ^
        status.hashCode ^
        isFavorite.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        category.hashCode;
  }

  Product copyWith({
    int? id,
    int? productId,
    int? categoryId,
    String? name,
    String? description,
    String? image,
    String? price,
    int? stock,
    int? status,
    int? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    Category? category,
  }) {
    return Product(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
    );
  }
}

class Category {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
