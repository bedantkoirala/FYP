import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/constants.dart';

import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecom_2/app/modules/detailed_product/controllers/detailed_product_controller.dart';
import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class DetailedProductView extends GetView<DetailedProductController> {
  final product = Get.arguments as Product;

  DetailedProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title?.toUpperCase() ?? '',
          style: const TextStyle(
            color: Color(0xFF07364A),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
              Get.find<MainController>().currentIndex.value = 3;
            },
            icon: const Icon(Icons.shopping_cart),
            color: const Color(0xFF07364A),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: 'product+${product.productId}',
                  child: Image.network(
                    getImageUrl(product.imageUrl ?? ''),
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Add a line below the photo
              const Divider(), // Divider line below the photo
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title?.toUpperCase() ?? '',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.rating.value != null,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.orange),
                          Text(
                            controller.rating.value ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Genre: ${product.categoryTitle ?? ""}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Rs. ${product.price.toString()}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Genre: ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Product Description:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ReadMoreText(
                product.description ?? '',
                trimMode: TrimMode.Line,
                trimLines: 3,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                lessStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                moreStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(), // Divider line below the product description
              GetBuilder<DetailedProductController>(
                builder: (controller) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Reviews: (${controller.reviewsResponse?.reviews?.length ?? 0})",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => const ReviewDialog());
                      },
                      child: const Text('Give Review'),
                    ),
                  ],
                ),
              ),
              GetBuilder<DetailedProductController>(
                builder: (controller) {
                  if (controller.reviewsResponse == null) {
                    return const SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (controller.reviewsResponse!.reviews!.isEmpty) {
                    return const Center(child: Text('No reviews yet'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.reviewsResponse!.reviews!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          controller
                                  .reviewsResponse!.reviews![index].fullName ??
                              '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          controller.reviewsResponse!.reviews![index].review
                              .toString(),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.orange),
                            Text(
                              controller.reviewsResponse!.reviews![index].rating
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (controller.quantity > 1) {
                      controller.quantity--;
                    }
                  },
                  icon: const Icon(Icons.remove),
                  color: Colors.red,
                ),
                Obx(
                  () => Text(
                    controller.quantity.toString(),
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.quantity++;
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 10),
            MyButton(
              tittle: 'Add to Cart',
              onPressed: () {
                cartController.addProduct(
                  product: product,
                  quantity: controller.quantity.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewDialog extends StatelessWidget {
  const ReviewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailedProductController>();
    return Dialog(
      backgroundColor: Colors.white, // Change background color to white
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Review',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF07364A),
              ),
            ),
            const SizedBox(height: 20),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.selectedRating.value = rating;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.reviewController,
              minLines: 2,
              maxLines: 3,
              maxLength: 500,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Review (optional)',
                hintText: 'Enter your review',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.giveReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF07364A),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
