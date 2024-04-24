import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:ecom_2/app/model/order.dart';
import 'package:ecom_2/app/model/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class OrderCard extends StatefulWidget {
  final Order order;
// List of ordered products
  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  List<Product>? orderedProducts;
  bool _expanded = false;
  bool loading = false;

  void getOrderDetails() async {
    try {
      setState(() {
        loading = true;
      });
      var url = Uri.http(ipAddress, 'ecom2_api/getOrderDetails');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'order_id': widget.order.orderId.toString(),
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        orderedProducts = productFromJson(jsonEncode(result['data']));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: Color(0xFF07364A),
            width: 2,
          ),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${widget.order.orderId}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total: Rs. ${widget.order.total}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Status: ${widget.order.status == 'paid' ? 'Paid' : 'Failed'}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      widget.order.status == 'paid' ? Colors.green : Colors.red,
                ),
              ),
              if (widget.order.fullName != null &&
                  widget.order.email != null) ...[
                const SizedBox(height: 10),
                Text(
                  'Customer: ${widget.order.fullName}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Email: ${widget.order.email}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _expanded = !_expanded;
                    if (_expanded) {
                      getOrderDetails();
                    }
                  });
                },
                child: Text(
                  _expanded ? 'See less' : 'See more',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              if (_expanded && loading) ...[
                const SizedBox(height: 10),
                const Center(child: CircularProgressIndicator()),
              ],
              if (_expanded && orderedProducts != null) ...[
                const SizedBox(height: 10),
                const Text(
                  'Items Ordered:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Total Items: ${orderedProducts!.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const Divider(),
                const SizedBox(height: 5),
                for (var product in orderedProducts!)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.title}', // Assuming Product model has title and quantity properties
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Quantity: ${product.quantity}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Price: Rs.${product.price}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
