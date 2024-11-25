import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateRegistrationController extends GetxController {
  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxBool showPassword = false.obs;

  void showLoadingPopup() {
    GeneralDialog.showLoadingDialog();
  }

  Future<void> onRegister() async {
    showLoadingPopup();
    try {
      UserCredential userCredential = await _fireAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        print("User registered: ${user.email}");

        _fireStore.collection("users").add({
          "username": usernameController.text,
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "full_name": "${firstNameController.text} ${lastNameController.text}",
          "isActive": false,
          "email": emailController.text,
          "phone": phoneController.text,
          "address": "",
        });

        Get.toNamed(Routes.registerSuccess);
      }
    } on FirebaseAuthException catch (e) {
      while (Get.isDialogOpen == true) {
        Get.back();
      }
      if (e.code == 'email-already-in-use') {
        print('The email address is already in use by another account.');
        Get.snackbar(
          'Failed',
          'The email address is already in use by another account.',
          backgroundColor: AppTheme.red500,
          colorText: Colors.white,
        );
      } else if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Get.snackbar(
          'Failed',
          'The password provided is too weak.',
          backgroundColor: AppTheme.red500,
          colorText: Colors.white,
        );
      } else {
        print(e.message);
        Get.snackbar(
          'Failed',
          e.message ?? 'An unexpected error occurred.',
          backgroundColor: AppTheme.red500,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
      while (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }
}