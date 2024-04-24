import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import '../../../utils/memoryManagement.dart';
import '../../home/controllers/home_controller.dart';

class AdminCategoriesController extends GetxController {
  //TODO: Implement AdminCategoriesController

  void onDeleteClicked({String? categoryId}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteCategory');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.post(url, body: {
        'category_id': categoryId,
        'token': MemoryManagement.getAccessToken()
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        var homeController = Get.find<HomeController>();
        homeController.getProducts();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  final count = 0.obs;

  void increment() => count.value++;

  static void removeAt(int index) {}
}
