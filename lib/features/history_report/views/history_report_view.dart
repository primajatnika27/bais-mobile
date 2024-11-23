import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/empty_list_widget.dart';
import 'package:bais_mobile/features/history_report/controllers/create_history_report_controller.dart';
import 'package:bais_mobile/features/history_report/widgets/history_card.dart';
import 'package:bais_mobile/features/history_report/widgets/history_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryReportView extends GetView<CreateHistoryReportController> {
  const HistoryReportView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateHistoryReportController());
    controller.getLocalData();
    return Scaffold(
      appBar: AppBarGeneral(
        title: 'History Report',
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Report Summary',
                    style: TextStyle(
                      color: AppTheme.secondary800,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const HistoryDashboard(),
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
                    onTap: () {},
                    child: const Text(
                      'View All',
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
            Expanded(
              child: Obx(() {
                return controller.taskReports.isEmpty
                    ? _emptyWidget()
                    : ListView.builder(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: controller.taskReports.length,
                  itemBuilder: (context, index) {
                    return HistoryCard(
                      data: controller.taskReports[index],
                    );
                  },
                );
              }),
            ),
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
