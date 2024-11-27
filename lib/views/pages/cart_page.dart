import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (cartController.cartList.isEmpty) {
          return const Center(child: Text("No items in the cart"));
        }

        return ListView.builder(
          itemCount: cartController.cartList.length,
          itemBuilder: (context, index) {
            final meal = cartController.cartList[index];
            return ListTile(
              leading: Image.network(meal.strMealThumb, width: 50, height: 50),
              title: Text(meal.strMeal),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {
                  cartController.removeFromCart(meal);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
