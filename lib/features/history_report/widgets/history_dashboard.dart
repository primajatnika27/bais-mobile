import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/features/history_report/controllers/create_history_report_controller.dart';
import 'package:bais_mobile/features/history_report/widgets/history_dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryDashboard extends GetView<CreateHistoryReportController> {
  const HistoryDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 82,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          children: [
            HistoryDashboardCard(
              icon: 'assets/icons/ic_checklist.svg',
              iconBackgroundColor: AppTheme.green100,
              total: controller.lastTimeIncidentTotal.value,
              title: 'Last time Incident',
              onTap: () {},
            ),
            const SizedBox(width: 16),
            HistoryDashboardCard(
              icon: 'assets/icons/ic_checklist.svg',
              iconBackgroundColor: AppTheme.blue100,
              total: controller.medicalTreatmentTotal.value,
              title: 'Medical Incident',
              onTap: () {},
            ),
            const SizedBox(width: 16),
            HistoryDashboardCard(
              icon: 'assets/icons/ic_checklist.svg',
              iconBackgroundColor: AppTheme.orange100,
              total: controller.minorIncidentTotal.value,
              title: 'Minor Incident',
              onTap: () {},
            ),
            const SizedBox(width: 16),
            HistoryDashboardCard(
              icon: 'assets/icons/ic_checklist.svg',
              iconBackgroundColor: AppTheme.red100,
              total: controller.nearMissTotal.value,
              title: 'Near Miss',
              onTap: () {},
            ),
            const SizedBox(width: 16),
            HistoryDashboardCard(
              icon: 'assets/icons/ic_checklist.svg',
              iconBackgroundColor: AppTheme.red100,
              total: controller.potentialHazardTotal.value,
              title: 'Potential Hazard',
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }
}
