import 'package:get/get.dart';
import 'package:machine_test/models/meals_model.dart';

class CartController extends GetxController {
  var cartList = <MealsModel>[].obs;

  void addToCart(MealsModel meal) {
    cartList.add(meal);
  }

  void removeFromCart(MealsModel meal) {
    cartList.remove(meal);
  }
}
