import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  title: const Text(
                    'Confirm Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text(
                    'Are you sure you want to logout?',
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        MemoryManagement.removeAll();
                        Get.offAllNamed(Routes.LOGIN);
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            if (controller.user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var expiryDate =
                DateTime.tryParse(MemoryManagement.getMembershipExpiry() ?? '');
            var isMembershipActive =
                expiryDate != null && expiryDate.isAfter(DateTime.now());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      child: Text(
                        (controller.user?.fullName?[0].toUpperCase() ?? '') +
                            (controller.user?.fullName?[1].toUpperCase() ?? ''),
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Hello, ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              controller.user?.fullName ?? '',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          controller.user?.email ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Role: ${MemoryManagement.getAccessRole()?.toUpperCase() ?? ''}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Visibility(
                          visible: MemoryManagement.getAccessRole() == 'user',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Membership: ${isMembershipActive ? 'Active' : 'Inactive'}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isMembershipActive
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                isMembershipActive
                                    ? 'Expires on: ${DateFormat.yMMMd().format(expiryDate)}'
                                    : 'Expired on: ${expiryDate != null ? DateFormat.yMMMd().format(expiryDate) : 'N/A'}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: isMembershipActive
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Account Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    'Full Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    controller.user?.fullName ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    controller.user?.email ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Conditionally render the Wishlist button based on user's role
                MemoryManagement.getAccessRole() != 'admin'
                    ? buildProfileButton(
                        text: 'My Wishlist',
                        route: Routes.Favorite,
                      )
                    : const SizedBox(height: 20),
                // Conditionally render the Wishlist button based on user's role
                MemoryManagement.getAccessRole() != 'user'
                    ? buildProfileButton(
                        text: 'Manage Membership',
                        route: Routes.MEMBERSHIP,
                      )
                    : const SizedBox(),
                const SizedBox(height: 10),
                buildProfileButton(
                  text: 'Edit My Profile',
                  route: Routes.EDIT_PROFILE,
                  args: controller.user,
                ),
                const SizedBox(height: 10),
                buildProfileButton(
                  text: 'Change My Password',
                  route: Routes.CHANGE_PASSWORD,
                ),
                const SizedBox(height: 10),
                buildProfileButton(
                  text: 'See Order Details',
                  route: Routes.ORDER,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildProfileButton(
      {required String text, required String route, dynamic args}) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(route, arguments: args);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
            bottom: Radius.zero,
          ),
          side: BorderSide(color: Colors.grey),
        ),
        elevation: 0,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.grey[800],
          ),
        ],
      ),
    );
  }
}
