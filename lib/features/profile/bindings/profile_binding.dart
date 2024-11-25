import 'package:bais_mobile/features/profile/controllers/create_profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateProfileController());
  }
}