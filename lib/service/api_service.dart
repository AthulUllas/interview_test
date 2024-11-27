import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CategoryService extends GetxService {
  final String apiUrl =
      'https://www.themealdb.com/api/json/v1/1/categories.php';

  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> categories = data['categories'];
        final categoryList = categories
            .map<String>((category) => category['strCategory'] as String)
            .toList();
        return categoryList;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
