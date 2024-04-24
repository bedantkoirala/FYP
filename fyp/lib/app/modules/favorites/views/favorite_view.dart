import 'package:ecom_2/app/modules/favorites/controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            color: Color(0xFF07364A), // Set text color to white
            fontFamily: 'YourCustomFont', // Apply custom font
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        flexibleSpace: Container(),
      ),
      body: GetBuilder<FavoriteController>(
        builder: (controller) {
          if (controller.userFav.isEmpty) {
            return const Center(
              child: Text(
                'Your wishlist is empty',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 141, 140, 140)),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.userFav.length,
                      itemBuilder: (context, index) {
                        return UserFavCard(
                          favItem: controller.userFav[index],
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class UserFavCard extends StatelessWidget {
  final FavItem favItem;
  final int index;
  const UserFavCard({
    Key? key,
    required this.favItem,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavoriteController>();

    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.white, // Change background color to white
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  getImageUrl(favItem.product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favItem.product.title ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Genre: ${favItem.product.categoryTitle ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: Rs ${favItem.product.price}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                controller.removeUserFav(index);
                Get.snackbar(
                    'Book Deleted', 'Book has been deleted from favorites',
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                    snackPosition: SnackPosition.BOTTOM);
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                controller.addToCart(favItem.product);
              },
              icon: const Icon(
                Icons.add_shopping_cart,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
