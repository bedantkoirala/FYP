import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Obx(() {
        return controller.screens[controller.currentIndex.value];
      }),
      bottomNavigationBar: Container(
        height: 70, // Increased height
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.favorite, 'Wishlist', 1),
            _buildNavItem(Icons.list, 'Orders', 2),
            _buildNavItem(Icons.shopping_cart, 'Cart', 3),
            _buildNavItem(Icons.person, 'Profile', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        controller.currentIndex.value = index; // Update currentIndex
      },
      child: Obx(() {
        bool isSelected = controller.currentIndex.value == index;
        return Container(
          padding: const EdgeInsets.symmetric(
              vertical: 13, horizontal: 10), // Adjusted padding
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected ? const Color(0xFF07364A) : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF07364A),
                size: 28,
              ),
              const SizedBox(width: 10),
              if (isSelected)
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
