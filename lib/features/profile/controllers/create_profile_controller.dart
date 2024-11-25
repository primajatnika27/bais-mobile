import 'package:bais_mobile/config/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateProfileController extends GetxController {
  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var usersName = "".obs;
  var emailUser = "".obs;
  var phone = "".obs;
  var address = "".obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void onSignOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.offAllNamed(Routes.signIn);
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('userEmail');

    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        emailUser.value = snapshot.docs.first['email'];
        usersName.value = snapshot.docs.first['full_name'];
        phone.value = snapshot.docs.first['phone'].toString();
        address.value = snapshot.docs.first['address'];
      }
  } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }
}