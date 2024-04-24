import 'package:ecom_2/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditUserController>(() => EditUserController());
  }
}
