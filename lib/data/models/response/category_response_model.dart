// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategroyResponseModel {
  final String status;
  final List<CategoryModel> data;

  CategroyResponseModel({
    required this.status,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory CategroyResponseModel.fromMap(Map<String, dynamic> map) {
    return CategroyResponseModel(
      status: map['status'] as String,
      data: List<CategoryModel>.from(
        (map['data']).map<CategoryModel>(
          (x) => CategoryModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory CategroyResponseModel.fromJson(String str) =>
      CategroyResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}

class CategoryModel {
  int? id;
  String? name;
  int? categoryId;
  int? isSync;
  String? image;
  // DateTime createdAt;
  // DateTime updatedAt;

  CategoryModel({this.id, this.name, this.categoryId, this.isSync, this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'name': name,
      'is_sync': isSync ?? 1,
      'category_id': id,
      'image': image
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
        id: map['id'] as int?,
        name: map['name'] as String?,
        isSync: map['is_sync'] as int?,
        categoryId: map['id'],
        image: map['image']);
  }

  factory CategoryModel.fromJson(String str) =>
      CategoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
