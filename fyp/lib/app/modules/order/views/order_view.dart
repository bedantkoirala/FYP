import 'package:ecom_2/app/components/order_card.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            MemoryManagement.getAccessRole() == 'admin'
                ? 'All Orders'
                : 'My Orders',
            style: const TextStyle(
              color: Color(0xFF07364A),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Paid Orders',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF07364A)),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Failed Orders',
                    style: TextStyle(
                      color: Color(0xFF07364A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            indicatorColor: Color(0xFF07364A), // Change the color here
          ),
        ),
        body: TabBarView(
          children: [
            _buildPaidOrders(),
            _buildFailedOrders(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaidOrders() {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        if (controller.orders == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final paidOrders = controller.orders!
            .where((order) => order.status == 'paid')
            .toList();
        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: paidOrders.length,
          itemBuilder: (context, index) => OrderCard(order: paidOrders[index]),
        );
      },
    );
  }

  Widget _buildFailedOrders() {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        if (controller.orders == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final failedOrders = controller.orders!
            .where((order) => order.status != 'paid')
            .toList();
        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: failedOrders.length,
          itemBuilder: (context, index) =>
              OrderCard(order: failedOrders[index]),
        );
      },
    );
  }
}
