import 'dart:convert';

class OutletModel {
  final int? id;
  final String? name;
  final String? address1;
  final String? address2;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  OutletModel({
    this.id,
    this.name,
    this.address1,
    this.address2,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address1': address1,
      'address2': address2,
      'phone': phone,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory OutletModel.fromMap(Map<String, dynamic> map) {
    return OutletModel(
      id: map['id'],
      name: map['name'],
      address1: map['address1'],
            address2: map['address2'],

      phone: map['phone'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OutletModel.fromJson(String source) =>
      OutletModel.fromMap(json.decode(source));
}
