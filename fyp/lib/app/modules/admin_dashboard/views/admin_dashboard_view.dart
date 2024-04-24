import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xFF07364A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: GetBuilder<AdminDashboardController>(
          init: AdminDashboardController(),
          builder: (controller) {
            if (controller.stats == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.getStats();
              },
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  StatsCard(
                    label: 'Total Income',
                    icon: Icons.notes,
                    isAmount: true,
                    value: controller.stats?.totalIncome != null
                        ? '${controller.stats?.totalIncome}'
                        : '0',
                  ),
                  StatsCard(
                    label: 'Total Members',
                    icon: Icons.card_membership,
                    value: controller.stats?.totalSubscriptions != null
                        ? controller.stats?.totalSubscriptions.toString() ?? ''
                        : '0',
                  ),
                  StatsCard(
                    label: 'Reviews',
                    icon: Icons.star_border,
                    value: controller.stats?.totalFeedbacks != null
                        ? controller.stats?.totalFeedbacks.toString() ?? ''
                        : '0',
                  ),
                  StatsCard(
                    label: 'Total Users',
                    icon: Icons.people,
                    value: controller.stats?.totalUsers != null
                        ? controller.stats?.totalUsers.toString() ?? ''
                        : '0',
                  ),
                  StatsCard(
                    label: 'Total Books',
                    icon: Icons.shopping_bag,
                    value: controller.stats?.totalProducts != null
                        ? controller.stats?.totalProducts.toString() ?? ''
                        : '0',
                  ),
                  StatsCard(
                    label: 'Total Orders',
                    icon: Icons.shopping_cart,
                    value: controller.stats?.totalOrders != null
                        ? controller.stats?.totalOrders.toString() ?? ''
                        : '0',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool isAmount;

  const StatsCard({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
    this.isAmount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case 'Total Users':
            Get.toNamed(Routes.ADMIN_USERS);
            break;
          case 'Total Books':
            Get.toNamed(Routes.ADMIN_PRODUCTS);
            break;
          case 'Total Orders':
            Get.toNamed(Routes.ORDER);
            break;
          case 'Total Income':
            // Handle navigation for Total Income
            break;
          case 'Reviews':
            break;
          case 'Total Members':
            Get.toNamed(Routes.MEMBERSHIP);

            break;
        }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Color(0xFF07364A),
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF07364A),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              (isAmount ? 'Rs. ' : '') + value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF07364A),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
