import 'package:get/get.dart';

import '../controllers/buy_membership_controller.dart';

class BuyMembershipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyMembershipController>(
      () => BuyMembershipController(),
    );
  }
}
