// lib/data/datasources/category_local_datasource.dart
import 'dart:convert';
import 'package:seblak_sulthane_app/data/models/response/category_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryLocalDatasource {
  final String cacheKey = 'cached_categories';

  Future<bool> saveCategories(List<CategoryModel> categories) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> categoriesMap =
          categories.map((category) => category.toMap()).toList();
      final String encodedData = jsonEncode(categoriesMap);

      return await prefs.setString(cacheKey, encodedData);
    } catch (e) {
      return false;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? cachedData = prefs.getString(cacheKey);

      if (cachedData == null || cachedData.isEmpty) {
        return [];
      }

      final List<dynamic> decodedData = jsonDecode(cachedData);
      return decodedData.map((json) => CategoryModel.fromMap(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
