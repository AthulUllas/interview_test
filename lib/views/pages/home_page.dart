import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/cart_controller.dart';
import 'package:machine_test/controller/category_controller.dart';
import 'package:machine_test/controller/meal_controller.dart';
import 'package:machine_test/views/pages/cart_page.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
    final categoryController = Get.find<CategoryController>();

    if (categoryController.categoriesList.isEmpty) {
      categoryController.fetchCategories();
    }
    final MealController mealController = Get.put(MealController());
    final CartController cartController = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Zone"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {
                  Get.to(() => const CartPage());
                },
                icon: const Icon(Icons.card_travel)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              if (categoryController.isLoading.value) {
                return const CircularProgressIndicator(); // Show loading indicator
              } else if (categoryController.categoriesList.isEmpty) {
                return const Text('No categories available');
              }

              return DropdownButton<String>(
                value: categoryController.selectedCategory.value.isEmpty
                    ? null
                    : categoryController.selectedCategory.value,
                hint: Text(mealController.selectedCategory.toString()),
                isExpanded: true,
                items: categoryController.categoriesList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newCategory) {
                  if (newCategory != null) {
                    mealController.changeCategory(newCategory);
                  }
                },
              );
            }),
            Obx(() {
              if (mealController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (mealController.mealsList.isEmpty) {
                return const Center(child: Text('No meals found'));
              }

              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 50,
                  ),
                  itemCount: mealController.mealsList.length,
                  itemBuilder: (context, index) {
                    final meal = mealController.mealsList[index];
                    return Stack(
                      children: [
                        Image.network(meal.strMealThumb),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 4),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.yellow),
                            child: IconButton(
                                onPressed: () {
                                  cartController.addToCart(meal);
                                },
                                icon: const Icon(Icons.add)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Text(
                              meal.strMeal,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}






// SizedBox(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             width: 90,
//                             height: 90,
//                             child: Image.network(
//                               meal.strMealThumb,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                           Text(meal.strMeal),
//                           IconButton(
//                               onPressed: () {
//                                 cartController.addToCart(meal);
//                               },
//                               icon: const Icon(
//                                 Icons.add,
//                                 size: 32,
//                               ))
//                         ],
//                       ),
//                     );