import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/fade_animation.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/features/auth/registration/controllers/create_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RegistrationView extends GetView<CreateRegistrationController> {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneral(
        backgroundColor: AppTheme.primary,
        withTabBar: true,
        title: '',
        onTapLeading: () {
          Get.back();
          Get.delete<CreateRegistrationController>();
        },
      ),
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
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const FadeInAnimation(
                        delay: 2.8,
                        child: Text(
                          "Hello! Register to get started",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                              placeholder: "ex: johndoe123",
                              title: "Username",
                            ),
                            const SizedBox(height: 24),
                            TextFieldWidget(
                              controller: controller.firstNameController,
                              placeholder: "John",
                              title: "First Name",
                            ),
                            const SizedBox(height: 24),
                            TextFieldWidget(
                              controller: controller.lastNameController,
                              placeholder: "Doe",
                              title: "Last Name",
                            ),
                            const SizedBox(height: 24),
                            TextFieldWidget(
                              controller: controller.emailController,
                              placeholder: "xxx@xx.com",
                              title: "Email",
                            ),
                            const SizedBox(height: 24),
                            TextFieldWidget(
                              controller: controller.phoneController,
                              placeholder: "+62xxx",
                              keyboardType: TextInputType.number,
                              title: "Phone Number",
                            ),
                            const SizedBox(height: 24),
                            Obx(
                              () {
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
                              },
                            ),
                            const SizedBox(height: 24),
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
      bottomNavigationBar: BottomButtonWidget(
        title: 'Submit',
        onTap: () {
          controller.onRegister();
        },
      ),
    );
  }
}
