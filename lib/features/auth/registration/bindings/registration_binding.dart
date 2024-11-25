import 'package:bais_mobile/features/auth/registration/controllers/create_registration_controller.dart';
import 'package:get/get.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRegistrationController>(() => CreateRegistrationController());
  }
}