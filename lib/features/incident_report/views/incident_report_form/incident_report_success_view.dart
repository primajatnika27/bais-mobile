import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/custom_widget.dart';
import 'package:bais_mobile/core/widgets/fade_animation.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IncidentReportSuccessView extends StatelessWidget {
  const IncidentReportSuccessView({super.key});

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
                "Report Incident",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const FadeInAnimation(
              delay: 1.5,
              child: Text(
                "Success to submit report",
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
                message: "Back",
                function: () {
                  Get.offAndToNamed(Routes.home);
                  Get.delete<IncidentReportController>();
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
