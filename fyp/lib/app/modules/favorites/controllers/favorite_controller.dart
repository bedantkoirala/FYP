import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/product.dart';
import '../../../utils/memoryManagement.dart';
import '../../cart/controllers/cart_controller.dart'; // Import the CartController

class FavoriteController extends GetxController {
  List<FavItem> userFav = [];
  final count = 0.obs;

  void increment() => count.value++;

  void addUserfav({required Product product}) {
    if (userFav
        .any((element) => element.product.productId == product.productId)) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.green,
        message: 'Book already in Favourites!',
        duration: Duration(seconds: 3),
      ));
      return;
    }
    userFav.add(FavItem(product: product));
    updateLocal();
    update();
  }

  void mapUserFav() {
    var userFav =
        jsonDecode(MemoryManagement.getFavorite() ?? '[]') as List<dynamic>;
    this.userFav = userFav
        .map((e) => FavItem(product: Product.fromJson(e['product'])))
        .toList();
  }

  void updateLocal() {
    MemoryManagement.setFavorite(jsonEncode(userFav
        .map((e) => {
              'product': e.product.toJson(),
            })
        .toList()));
  }

  void removeUserFav(int index) {
    userFav.removeAt(index);
    updateLocal();
    update();
  }

  // Method to add a product to the cart
  void addToCart(Product product) {
    CartController cartController =
        Get.find<CartController>(); // Get the CartController
    cartController.addProduct(product: product); // Add the product to the cart
  }
}

class FavItem {
  final Product product;

  FavItem({required this.product});
}
