import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/button_widget.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/features/auth/signIn/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: const BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 24, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Image.asset(
                        'assets/images/logo-maruti.png',
                        height: 120,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Welcome to Bais Mobile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              controller: controller.usernameController,
                              placeholder: "ex: John Doe",
                              title: "Username",
                            ),
                            const SizedBox(height: 24),
                            Obx(() {
                              return TextFieldWidget(
                                controller: controller.passwordController,
                                placeholder: "",
                                title: "Password",
                                obscureText: !controller.showPassword.value,
                                prefixIcon: SvgPicture.asset(
                                    'assets/icons/ic_lock.svg'),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    controller.showPassword.value =
                                        !controller.showPassword.value;
                                  },
                                  child: (!controller.showPassword.value)
                                      ? SvgPicture.asset(
                                          'assets/icons/ic_eye_open.svg')
                                      : SvgPicture.asset(
                                          'assets/icons/ic_eye_close.svg'),
                                ),
                              );
                            }),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  foregroundColor: AppTheme.primary,
                                ),
                                child: const Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 80),
                            SizedBox(
                              width: double.infinity,
                              child: ButtonWidget(
                                text: "Login",
                                styleType: ButtonStyleType.fill,
                                fillColor: AppTheme.primary,
                                textColor: AppTheme.white950,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                onPressed: () {
                                  Get.offAllNamed(Routes.home);
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
