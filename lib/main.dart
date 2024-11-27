import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machine_test/service/api_service.dart';
import 'package:machine_test/views/pages/home_page.dart';

void main() {
  Get.put(CategoryService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
