import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/membership.dart';
import 'package:ecom_2/app/model/subscription.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';

class MembershipController extends GetxController {
  MembershipResponse? membershipResponse;
  Membership? selectedMembership;
  SubscriptionResponse? subscriptionResponse;

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var durationController = TextEditingController();
  var discountController = TextEditingController();

  void onSelectMembership(Membership membership) {
    selectedMembership = membership;
    update();
  }

  void addMembership() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      var url = Uri.http(ipAddress, 'ecom2_api/addMembership');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'title': titleController.text,
        'description': descriptionController.text,
        'price': priceController.text,
        'duration_months': durationController.text,
        'discount_percentage': discountController.text,
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        Get.close(1);
        getMemberships();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getMemberships();
    getSubscriptions();
  }

  void getMemberships() async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getMembership');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = membershipResponseFromJson(response.body);
      if (result.success ?? false) {
        membershipResponse = result;
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result.message ?? '',
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

  void getSubscriptions() async {
    if (MemoryManagement.getAccessRole() != 'admin') {
      return;
    }
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/getSubscription');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = subscriptionResponseFromJson(response.body);
      if (result.success ?? false) {
        subscriptionResponse = result;
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result.message ?? '',
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

  void onContinue() {
    KhaltiScope.of(Get.context!).pay(
      preferences: [
        PaymentPreference.khalti,
      ],
      config: PaymentConfig(
        amount: 1000,
        productIdentity: "MID_${selectedMembership!.membershipId}",
        productName:
            "Membership ${selectedMembership!.name} for ${selectedMembership!.durationMonths} months",
      ),
      onSuccess: (PaymentSuccessModel v) {
        saveSubscription(
          total: selectedMembership!.price.toString(),
          membershipId: selectedMembership!.membershipId.toString(),
          otherData: v.toString(),
        );
      },
      onFailure: (v) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Payment failed!',
          duration: Duration(seconds: 3),
        ));
      },
      onCancel: () {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: 'Payment cancelled!',
          duration: Duration(seconds: 3),
        ));
      },
    );
  }

  void saveSubscription(
      {required String total,
      required String membershipId,
      required String otherData}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/saveSubscription');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'total': total,
        'membership_id': membershipId,
        'other_data': otherData,
      });

      print(response.body);

      var result = jsonDecode(response.body);

      if (result['success']) {
        MemoryManagement.saveMembershipExpiry(result['expires_at']);
        MemoryManagement.saveDiscountPercentage(result['discount']);
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 5),
        ));
        Get.offAllNamed(Routes.MAIN);
        update();
        // Get.back();
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
        duration: Duration(seconds: 0),
      ));
    }
    return null;
  }

  Future<void> deleteMembership(String membershipId) async {
    try {
      var url = Uri.http(ipAddress, 'ecom2_api/deleteMembership');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'membership_id': membershipId,
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        // ignore: deprecated_member_use
        Get.showSnackbar(GetBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        // Refresh the memberships list after deletion
        getMemberships();
      } else {
        Get.showSnackbar(GetBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(GetBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }
}
