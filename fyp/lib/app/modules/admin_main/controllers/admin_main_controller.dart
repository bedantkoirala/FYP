import 'package:ecom_2/app/modules/admin_categories/views/admin_categories_view.dart';
import 'package:ecom_2/app/modules/admin_dashboard/views/admin_dashboard_view.dart';

import 'package:ecom_2/app/modules/admin_users/views/admin_users_view.dart';
import 'package:ecom_2/app/modules/order/views/order_view.dart';

import 'package:ecom_2/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMainController extends GetxController {
  // List of screens to be displayed in the bottom navigation bar
  final List<Widget> screens = [
    const AdminDashboardView(),
    const OrderView(),
    const AdminUsersView(),
    const AdminCategoriesView(),
    // const AdminProductsView(),
    const ProfileView(),
  ];

  // Current index of the bottom navigation bar
  final RxInt currentIndex = 0.obs;

  // Method to set the current index
  void setCurrentIndex(int index) {
    currentIndex.value = index;
    update(); // Trigger UI update
  }

  // List of icons for bottom navigation bar items
  final List<IconData> icons = [
    Icons.dashboard,
    Icons.people,
    Icons.category,
    Icons.shopping_bag,
    Icons.person,
  ];

  // List of labels for bottom navigation bar items
  final List<String> labels = [
    'Dashboard',
    'Users',
    'Categories',
    'Products',
    'Profile',
  ];

  // Method to increment the count
  void increment() {
    count.value++;
  }

  // Count observable
  final RxInt count = 0.obs;
}
