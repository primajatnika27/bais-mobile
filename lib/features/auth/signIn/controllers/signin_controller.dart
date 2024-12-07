import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  RxBool showPassword = false.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void showLoadingPopup() {
    GeneralDialog.showLoadingDialog();
  }

  @override
  void onReady() {
    checkLogin();
  }

  Future<void> checkLogin() async {
    showLoadingPopup();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLogin') == true) {
      Get.offAndToNamed(Routes.home);
    }
    while (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  Future<void> signIn() async {
    showLoadingPopup();
    try {
      String email = usernameController.text.trim();

      QuerySnapshot userQuery = await _fireStore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isNotEmpty &&
          userQuery.docs.first['isActive'] == true) {
        UserCredential userCredential =
            await _fireAuth.signInWithEmailAndPassword(
          email: email,
          password: passwordController.text.trim(),
        );
        User? user = userCredential.user;
        if (user != null) {
          String userDocId = userQuery.docs.first.id;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userEmail', user.email ?? '');
          await prefs.setString('userId', userDocId);
          await prefs.setString('userName', userQuery.docs.first['full_name']);
          await prefs.setBool('isLogin', true);

          await prefs.setString('initial-route', Routes.home);

          Get.offAndToNamed(Routes.home);
        }
      } else {
        while (Get.isDialogOpen == true) {
          Get.back();
        }

        GeneralDialog.showSnackBar(
          ContentType.failure,
          'Failed',
          'Your account is not active. Please contact support.',
        );
      }
    } on FirebaseAuthException catch (e) {
      while (Get.isDialogOpen == true) {
        Get.back();
      }

      GeneralDialog.showSnackBar(
        ContentType.failure,
        'Failed',
        e.message ?? 'An unexpected error occurred.',
      );
    }
  }
}
