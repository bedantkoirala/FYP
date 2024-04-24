import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as Category;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.categoryTitle ?? '',
          style: const TextStyle(
            color: Color(0xFF07364A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.products.isEmpty
            ? Center(
                child: SizedBox(
                  width: Get.width * 0.6,
                  child: const Text(
                    'No Products Found for this category!',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductCard(
                    product: product,
                    category: category.categoryTitle ?? '',
                  );
                },
              ),
      ),
    );
  }
}
