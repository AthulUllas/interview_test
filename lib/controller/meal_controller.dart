import 'package:get/get.dart';
import 'package:machine_test/models/meals_model.dart';
import 'package:machine_test/service/meal_service.dart';

class MealController extends GetxController {
  var mealsList = <MealsModel>[].obs;
  var isLoading = true.obs;
  var selectedCategory = 'beef'.obs; // Default category is "beef"

  @override
  void onInit() {
    super.onInit();
    fetchMeals(selectedCategory.value); // Fetch meals for default category
  }

  // Fetch meals based on the selected category
  void fetchMeals(String category) async {
    try {
      isLoading.value = true;
      final meals = await MealService().fetchData(category);
      mealsList.assignAll(meals);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Change the category and fetch meals
  void changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
    fetchMeals(newCategory);
  }
}
