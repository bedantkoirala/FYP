import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/modules/membership/controllers/membership_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/buy_membership_controller.dart';

class BuyMembershipView extends GetView<BuyMembershipController> {
  const BuyMembershipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MembershipController());
    var controller = Get.find<MembershipController>();

    var expiryDate =
        DateTime.tryParse(MemoryManagement.getMembershipExpiry() ?? '');
    var isMembershipActive =
        expiryDate != null && expiryDate.isAfter(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select a Plan',
          style: TextStyle(
            color: Color(0xFF07364A),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<MembershipController>(
        builder: (controller) {
          if (controller.membershipResponse == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (isMembershipActive) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 300,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'You are already an active member!',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Active till ${DateFormat.yMMMEd().format(expiryDate)}',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width * 0.8,
                    child: Text(
                      'Enjoy ${double.parse(MemoryManagement.getDiscountPercentage() ?? '0').toStringAsFixed(0)}% discount on all your purchases',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.membershipResponse?.memberships?.length,
            itemBuilder: (context, index) {
              var membership =
                  controller.membershipResponse?.memberships?[index];
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: controller.selectedMembership?.membershipId ==
                            membership?.membershipId
                        ? Color(0xFF07364A)
                        : Colors.transparent,
                  ),
                ),
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    onTap: () {
                      controller.onSelectMembership(membership!);
                    },
                    selected: controller.selectedMembership?.membershipId ==
                        membership?.membershipId,
                    title: Text(
                      membership?.name ?? '',
                      style: const TextStyle(
                        color: Color(0xFF07364A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.local_offer,
                                color: Colors.orange), // Discount icon
                            SizedBox(width: 4),
                            Text(
                              'Discount: ${membership?.discountPercentage}%',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.grey),
                            // Calendar icon
                            SizedBox(width: 4),
                            Text(
                              '${membership?.durationMonths} Months',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          membership?.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color(0xFF07364A),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'Rs.${membership?.price}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: !isMembershipActive
          ? GetBuilder<MembershipController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyButton(
                  tittle: 'Continue',
                  isDisabled: controller.selectedMembership == null,
                  onPressed: () {
                    controller.onContinue();
                  },
                ),
              ),
            )
          : null,
    );
  }
}
