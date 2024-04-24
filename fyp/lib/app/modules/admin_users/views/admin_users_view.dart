import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/model/user.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_users_controller.dart';

class AdminUsersView extends GetView<AdminUsersController> {
  const AdminUsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Admins & Users Details',
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
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: GetBuilder<AdminUsersController>(
          init: AdminUsersController(),
          builder: (controller) {
            if (controller.users == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: ListView.builder(
                  itemCount: controller.users!.length,
                  itemBuilder: (context, index) {
                    return UserCard(user: controller.users![index]);
                  }),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AddUserPopup(),
            );
          },
          label: const Text(
            'Add Admin',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xFF07364A),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminUsersController>();
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF07364A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user.email ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF07364A),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'Role: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF07364A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.role == 'admin' ? 'Admin' : 'User',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1EB0EE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete User'),
                    content: const Text('Are you sure?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.deleteUser(user.userId);
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
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

class AddUserPopup extends StatelessWidget {
  const AddUserPopup({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminUsersController>();
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set white background color
          borderRadius: BorderRadius.circular(20), // Apply border radius
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF07364A), // Add box shadow
              spreadRadius: 7,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Admin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        Color(0xFF07364A), // Text color similar to previous UI
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.nameController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Admin name',
                    hintText: 'Enter admin name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter admin name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.emailController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Admin email',
                    hintText: 'Enter admin email address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter admin email';
                    } else if (!value.isEmail) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  obscureText: true,
                  controller: controller.passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    labelText: 'Admin password',
                    hintText: 'Enter admin initial password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter admin password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                MyButton(
                  tittle: 'Add Admin',
                  onPressed: controller.addUser,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
