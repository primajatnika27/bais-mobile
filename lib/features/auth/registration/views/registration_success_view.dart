import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/custom_widget.dart';
import 'package:bais_mobile/core/widgets/fade_animation.dart';
import 'package:bais_mobile/features/auth/registration/controllers/create_registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegistrationSuccessView extends StatelessWidget {
  const RegistrationSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFE8ECF4),
      body: SafeArea(
        child: Column(
          children: [
            LottieBuilder.asset("assets/images/ticker.json"),
            const FadeInAnimation(
              delay: 1,
              child: Text(
                "Registration Success",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const FadeInAnimation(
              delay: 1.5,
              child: Text(
                "Your account has been created successfully",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FadeInAnimation(
              delay: 2,
              child: CustomElevatedButton(
                message: "Back to Login",
                function: () {
                  Get.offAllNamed(Routes.signIn);
                  Get.delete<CreateRegistrationController>();
                },
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
