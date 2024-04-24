import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditUserController extends GetxController {
  User? user;

  var fullNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  fetchUserProfile() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/editUsers');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        user = User.fromJson(result['data']);
        fullNameController.text = user!.fullName!;
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    }
  }

  updateUserDetail() async {
    try {
      // Check if full name field is empty
      if (fullNameController.text.isEmpty) {
        Get.snackbar('Error', 'Please fill in the full name field');
        return;
      }

      var url = Uri.http(ipAddress, 'ecom2_api/editUsers');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'full_name': fullNameController.text,
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.back();
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    }
  }
}
