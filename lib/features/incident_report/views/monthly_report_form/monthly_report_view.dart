import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/custom_tab_slider.dart';
import 'package:bais_mobile/features/incident_report/controllers/monthly_report_controller.dart';
import 'package:bais_mobile/features/incident_report/views/monthly_report_form/monthly_report_step_1_view.dart';
import 'package:bais_mobile/features/incident_report/views/monthly_report_form/monthly_report_step_2_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyReportView extends GetView<MonthlyReportController> {
  const MonthlyReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBarGeneral(
        title: 'Monthly Report',
        withTabBar: true,
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => CustomTabSlider(
                tabs: controller.tabs,
                currentIndex: controller.currentIndex.value,
                onTap: controller.changeTab,
              ),
            ),
            Expanded(
              child: Obx(
                () => _buildTabContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (controller.currentIndex.value) {
      case 0:
        return const MonthlyReportStep1View();
      case 1:
        return const MonthlyReportStep2View();
      default:
        return const SizedBox.shrink();
    }
  }
}
