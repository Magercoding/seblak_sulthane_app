import 'dart:convert';

class DiscountResponseModel {
  final String? status;
  final List<Discount>? data;

  DiscountResponseModel({
    this.status,
    this.data,
  });

  factory DiscountResponseModel.fromRawJson(String str) =>
      DiscountResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DiscountResponseModel.fromJson(Map<String, dynamic> json) {
    var rawData = json["data"];
    List<Discount> discountList = [];

    if (rawData != null) {
      if (rawData is List) {
        discountList = rawData.map((x) => Discount.fromJson(x)).toList();
      } else if (rawData is Map<String, dynamic>) {
        discountList = [Discount.fromJson(rawData)];
      }
    }

    return DiscountResponseModel(
      status: json["status"],
      data: discountList,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.map((x) => x.toJson()).toList() ?? [],
      };
}

class Discount {
  final int? id;
  final String? name;
  final String? description;
  final String? type;
  final String? value;
  final String? status;
  final dynamic expiredDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? category;

  Discount({
    this.id,
    this.name,
    this.description,
    this.type,
    this.value,
    this.status,
    this.expiredDate,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        value: json["value"],
        status: json["status"],
        expiredDate: json["expired_date"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"].toString())
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"].toString())
            : null,
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
        "value": value,
        "status": status,
        "expired_date": expiredDate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category,
      };
}
