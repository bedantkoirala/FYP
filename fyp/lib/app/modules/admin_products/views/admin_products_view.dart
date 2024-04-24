import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_products_controller.dart';

class AdminProductsView extends GetView<AdminProductsController> {
  const AdminProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminProductsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products Details',
          style: TextStyle(
            color: const Color(0xFF07364A), // Set text color to white
            fontFamily: 'YourCustomFont', // Apply custom font
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(),
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            if (controller.products == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: controller.products?.length ?? 0,
                itemBuilder: (context, index) {
                  return AdminProductCard(
                    product: controller.products![index],
                  );
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.onAdd,
        label: const Text(
          'Add Product',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF07364A), // Change background color
      ),
    );
  }
}
