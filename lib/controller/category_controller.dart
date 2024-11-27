import 'package:get/get.dart';
import 'package:machine_test/service/api_service.dart';

class CategoryController extends GetxController {
  var categoriesList = <String>[].obs;
  var isLoading = true.obs;
  var selectedCategory = ''.obs;

  Future<void> fetchCategories() async {
    try {
      final fetchedCategories =
          await Get.find<CategoryService>().fetchCategories();

      categoriesList.value = fetchedCategories;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
