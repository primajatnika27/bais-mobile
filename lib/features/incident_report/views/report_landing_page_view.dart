import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/empty_list_widget.dart';
import 'package:bais_mobile/features/history_report/widgets/history_card.dart';
import 'package:bais_mobile/features/incident_report/controllers/report_landing_page_controller.dart';
import 'package:bais_mobile/features/incident_report/widgets/report_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportLandingPageView extends StatelessWidget {
  const ReportLandingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportLandingPageController());
    controller.onInit();
    return Scaffold(
      appBar: AppBarGeneral(
        title: 'Report',
        withTabBar: true,
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ReportChart(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'History Report',
                    style: TextStyle(
                      color: AppTheme.secondary800,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.incidentReportHistory);
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () {
                return controller.taskReports.isEmpty
                    ? _emptyWidget()
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return HistoryCard(
                            data: controller.taskReports[index],
                          );
                        },
                      );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _emptyWidget() {
    return const EmptyListWidget(
      image: 'assets/images/ic_empty.png',
      title: "No history report found",
      subtitle: "It seems you don't have any history report yet.",
    );
  }
}
