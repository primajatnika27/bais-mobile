import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:bais_mobile/features/incident_report/widgets/incident_form_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncidentReportStep1View extends GetView<IncidentReportController> {
  const IncidentReportStep1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            IncidentFormTab(),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        title: 'Next',
        onTap: () {
          controller.changeTab(1);
        },
      ),
    );
  }
}
