import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/model/reviews.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:http/http.dart' as http;

class DetailedProductController extends GetxController {
  ReviewsResponse? reviewsResponse;
  final Product product = Get.arguments;
  var reviewController = TextEditingController();
  var quantity = 1.obs;

  Rx<String?> rating = ''.obs;

  var selectedRating = 1.0.obs;

  final count = 0.obs;

  @override
  void onInit() {
    rating.value = product.rating ?? '0';
    super.onInit();
    getReviews();
  }

  void getReviews() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getReviews');
      var response = await http.post(url, body: {
        'product_id': product.productId.toString(),
        'token': MemoryManagement.getAccessToken(),
      });

      var result = jsonDecode(response.body);
      if (result['success']) {
        rating.value = result['rating'] ?? '0';
        reviewsResponse = ReviewsResponse.fromJson(result);
        update();
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

  void giveReview() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/giveRating');

      var request = http.MultipartRequest('POST', url);

      request.fields['product_id'] = product.productId!;
      request.fields['token'] = MemoryManagement.getAccessToken()!;
      request.fields['rating'] = selectedRating.value.toString();
      if (reviewController.text.trim().isNotEmpty) {
        print("it is not empty");
        request.fields['review'] = reviewController.text;
      }

      var streamResponse = await request.send();

      var response = await http.Response.fromStream(streamResponse);

      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.find<HomeController>().getProducts();
        getReviews();
        reviewController.clear();
        selectedRating.value = 1.0;
        Get.close(1);
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 2),
          ),
        );
        update();
      } else {
        print(result['error']);
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
}
