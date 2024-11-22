import 'package:bais_mobile/core/snackbar/general_snackbar.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:bais_mobile/features/incident_report/widgets/incident_location_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentReportStep3View extends GetView<IncidentReportController> {
  const IncidentReportStep3View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: const [
            IncidentLocationTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        title: 'Submit',
        onTap: () {
          controller.onSubmitTaskReport();
          Get.back();
        },
      ),
    );
  }
}
