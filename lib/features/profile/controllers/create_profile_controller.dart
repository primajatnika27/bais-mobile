import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/services/shared_preference_service.dart';
import 'package:bais_mobile/data/repositories/profile_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CreateProfileController extends GetxController {
  var logger = Logger();
  final SharedPreferenceService prefs = Get.find<SharedPreferenceService>();
  final ProfileRepository _profileRepository = ProfileRepository();

  var usersName = "".obs;
  var emailUser = "".obs;
  var phone = "".obs;
  var address = "".obs;

  @override
  void onInit() {
    super.onInit();
    onGetUserData();
  }

  void onSignOut() async {
    await prefs.clear();
    Get.offAllNamed(Routes.signIn);
  }

  Future<void> onGetUserData() async {
    var email = prefs.getValue('userEmail');

    try {
      var snapshot = await _profileRepository.getUserDataByEmail(email);

      if (snapshot != null) {
        var data = snapshot.docs.first.data() as Map<String, dynamic>;
        usersName.value = data['full_name'] ?? '';
        emailUser.value = email;
        phone.value = data['phone'] ?? '';
        address.value = data['address'] ?? '';
      }
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }
}
