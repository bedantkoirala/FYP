import 'package:ecom_2/app/components/My_button.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/membership_controller.dart';

class MembershipView extends GetView<MembershipController> {
  const MembershipView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Membership Details',
          style: TextStyle(
            color: Color(0xFF07364A),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<MembershipController>(
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Memberships',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF07364A)),
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Subscriptions',
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
                Expanded(
                  child: TabBarView(children: [
                    if (controller.membershipResponse == null)
                      const Center(child: CircularProgressIndicator()),
                    if (controller.membershipResponse != null &&
                        (controller.membershipResponse?.memberships?.isEmpty ??
                            true))
                      const Center(child: Text('No Memberships Found')),
                    if (controller.membershipResponse != null &&
                        (controller
                                .membershipResponse?.memberships?.isNotEmpty ??
                            false))
                      ListView.builder(
                        itemCount:
                            controller.membershipResponse?.memberships?.length,
                        itemBuilder: (context, index) {
                          var membership = controller
                              .membershipResponse?.memberships?[index];
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        membership?.name ?? '',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          // Check if membershipId is not null before calling deleteMembership
                                          final membershipId =
                                              membership?.membershipId;
                                          if (membershipId != null) {
                                            // Call deleteMembership method from controller
                                            controller
                                                .deleteMembership(membershipId);
                                          } else {
                                            // Handle the case where membershipId is null
                                            print('Membership ID is null');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.local_offer,
                                          color:
                                              Colors.orange), // Discount icon
                                      SizedBox(width: 4),
                                      Text(
                                        'Discount: ${membership?.discountPercentage ?? 0}%',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.grey), // Calendar icon
                                      SizedBox(width: 4),
                                      Text(
                                        '${membership?.durationMonths ?? 0} Months',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    membership?.description ?? '',
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rs.${membership?.price ?? 0}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    if (controller.subscriptionResponse == null)
                      const Center(child: CircularProgressIndicator()),
                    if (controller.subscriptionResponse != null &&
                        (controller
                                .subscriptionResponse?.subscriptions?.isEmpty ??
                            true))
                      const Center(child: Text('No Subscriptions Found')),
                    if (controller.subscriptionResponse != null &&
                        (controller.subscriptionResponse?.subscriptions
                                ?.isNotEmpty ??
                            false))
                      ListView.builder(
                        itemCount: controller
                            .subscriptionResponse?.subscriptions?.length,
                        itemBuilder: (context, index) {
                          var membership = controller
                              .subscriptionResponse?.subscriptions?[index];

                          var expiryDate = membership?.expirationDate;
                          var isMembershipActive = expiryDate != null &&
                              expiryDate.isAfter(DateTime.now());
                          return Card(
                            color: Colors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    membership?.name ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          color: Colors.grey), // Date icon
                                      SizedBox(width: 4),
                                      Text(
                                        'Start Date: ${DateFormat.yMMMd().format(membership!.startDate!)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        'Expiry Date: ${DateFormat.yMMMd().format(membership!.expirationDate!)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors
                                              .blue.shade800), // User icon
                                      SizedBox(width: 8),
                                      Text(
                                        'Customer Details',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.blue.shade800,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Email: ${membership?.email ?? ''}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Full Name: ${membership.fullName ?? ''}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.badge,
                                          color: isMembershipActive
                                              ? Colors.blue.shade800
                                              : Colors
                                                  .red), // Membership status icon
                                      SizedBox(width: 8),
                                      Text(
                                        'Membership Status: ${isMembershipActive ? 'Active' : 'Expired'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: isMembershipActive
                                              ? Colors.blue.shade800
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Rs.${membership.amount ?? 0}',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ]),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Get.dialog(const AddMembership());
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Color(0xFF07364A), // Change button color
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white), // Add icon
              SizedBox(width: 5),
              Text(
                'Add Membership',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMembership extends StatelessWidget {
  const AddMembership({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Membership',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: GetBuilder<MembershipController>(
          builder: (controller) => SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.titleController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Membership Title',
                        hintText: 'Enter membership title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter membership title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.descriptionController,
                      textInputAction: TextInputAction.next,
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 1000,
                      decoration: const InputDecoration(
                        labelText: 'Membership Description',
                        hintText: 'Enter membership description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter membership description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.priceController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Membership Price (Rs)',
                        hintText: 'Enter membership price',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter membership price';
                        } else if (!GetUtils.isCurrency(value)) {
                          return 'Please enter valid price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.durationController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Duration (Months)',
                        hintText: 'Enter membership duration',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter membership duration';
                        } else if (!GetUtils.isNum(value)) {
                          return 'Please enter valid duration';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: controller.discountController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Discount (%)',
                        hintText: 'Enter discount percentage',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter discount percentage';
                        } else if (!GetUtils.isNum(value)) {
                          return 'Please enter valid discount percentage';
                        } else if (int.parse(value) < 0 ||
                            int.parse(value) > 100) {
                          return "Please enter valid discount percentage";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MyButton(
                      tittle: 'Add Membership',
                      onPressed: controller.addMembership,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
