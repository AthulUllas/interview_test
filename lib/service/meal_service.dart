import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:machine_test/models/meals_model.dart';

const baseUrl = "https://www.themealdb.com/api/json/v1/1/filter";

class MealService {
  Future<List<MealsModel>> fetchData(String categoryName) async {
    try {
      final query = Uri.encodeQueryComponent(categoryName);
      final url = Uri.parse("$baseUrl.php?c=$query");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception("Response from the API is empty");
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> mealsList = data['meals'];
        final List<MealsModel> meals =
            mealsList.map((e) => MealsModel.fromJson(e)).toList();
        return meals;
      } else {
        throw Exception("Failed to load data : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
