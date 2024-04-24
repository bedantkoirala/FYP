import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';

import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var expiryDate =
        DateTime.tryParse(MemoryManagement.getMembershipExpiry() ?? '');
    var isMembershipActive =
        expiryDate != null && expiryDate.isAfter(DateTime.now());
    var discountPercentage =
        double.tryParse(MemoryManagement.getDiscountPercentage() ?? '0');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: Color(0xFF07364A), // Set text color to white
            fontFamily: 'YourCustomFont', // Apply custom font
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              controller.cart.isEmpty
                  ?
                  // Show text when cart is empty
                  Padding(
                      padding: const EdgeInsets.only(top: 250, left: 90),
                      child: Column(
                        children: [
                          const Text(
                            'There are no books in this cart',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  20), // Add some space between text and button
                          ElevatedButton(
                            onPressed: () {
                              Get.find<MainController>().currentIndex.value = 0;
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Continue Shopping',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  :

                  // Show cart items when cart is not empty
                  Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.cart.length,
                          itemBuilder: (context, index) => CartCard(
                            cartItem: controller.cart[index],
                            index: index,
                          ),
                        ),
                      ),
                    ),
              // Checkout section
              controller.cart.isNotEmpty
                  ? Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                        bottom: 70,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                        borderRadius:
                            BorderRadius.circular(0), // Add border radius
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/khalti.png',
                                    width: 60,
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: isMembershipActive,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Subtotal: ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              'Rs. ${controller.beforeDiscount.value}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color(
                                                    0xFF07364A), // Change text color to indigo
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Row(
                                        children: [
                                          const Text(
                                            'Discount: ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Obx(
                                            () => Text(
                                              'Rs. ${controller.discount.value}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Your total: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        'Rs. ${controller.total.value}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .green, // Change text color to indigo
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (controller.cart.isEmpty) {
                                Get.showSnackbar(const GetSnackBar(
                                  backgroundColor: Colors.red,
                                  message: 'Cart is empty!',
                                  duration: Duration(seconds: 3),
                                ));
                                return;
                              }
                              var orderId = await controller.makeOrder();
                              if (orderId == null) {
                                return;
                              }
                              KhaltiScope.of(Get.context!).pay(
                                preferences: [
                                  PaymentPreference.khalti,
                                ],
                                config: PaymentConfig(
                                  amount: 1000,
                                  productIdentity: orderId.toString(),
                                  productName: "My Product",
                                ),
                                onSuccess: (PaymentSuccessModel v) {
                                  controller.makePayment(
                                    total: (v.amount / 100).toString(),
                                    orderId: orderId.toString(),
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
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF07364A),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Check Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    Colors.white, // Change text color to white
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(), // Hide checkout section if cart is empty
            ],
          ),
        ),
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  final int index;
  const CartCard({Key? key, required this.cartItem, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      color: Colors.white, // Change background color to white
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(getImageUrl(cartItem.product.imageUrl)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    cartItem.product.title ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Genre: ${cartItem.product.categoryTitle}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 113, 111, 111),
                    ),
                  ),

                  const SizedBox(height: 4),
                  // Product Price
                  Text(
                    'Price: Rs ${cartItem.product.price}',
                    style: const TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  const SizedBox(height: 4),
                  // Quantity Selector
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.decreaseQuantity(index);
                        },
                        icon: const Icon(Icons.remove),
                        color: Colors.red, // Change button color to red
                      ),
                      Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.increaseQuantity(index);
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.green, // Change button color to green
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Delete Button
            IconButton(
              onPressed: () {
                controller.removeProduct(index);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
