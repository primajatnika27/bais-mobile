import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/services/shared_preference_service.dart';
import 'package:bais_mobile/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final SharedPreferenceService prefs = Get.find<SharedPreferenceService>();
  final AuthRepository _authRepository = AuthRepository();

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
    if (prefs.getValue('isLogin') == true) {
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

      var userQuery = await _authRepository.getUserDataByEmail(email);

      if (userQuery?['isActive'] == true) {
        User? user = await _authRepository.login(
          email,
          passwordController.text.trim(),
        );

        if (user != null) {
          String userDocId = userQuery?.id ?? '';
          await prefs.setValue('userEmail', user.email ?? '');
          await prefs.setValue('userId', userDocId);
          await prefs.setValue('userName', userQuery?['full_name']);
          await prefs.setValue('isLogin', true);
          await prefs.setValue('initial-route', Routes.home);

          Get.offAndToNamed(Routes.home);
        } else {
          while (Get.isDialogOpen == true) {
            Get.back();
          }

          GeneralDialog.showSnackBar(
            ContentType.failure,
            'Failed',
            'Invalid email or password.',
          );
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
