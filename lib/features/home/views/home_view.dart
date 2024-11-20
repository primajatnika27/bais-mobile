import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/features/dashboard/views/dashboard_view.dart';
import 'package:bais_mobile/features/history_report/views/history_report_view.dart';
import 'package:bais_mobile/features/home/controllers/navigation_controller.dart';
import 'package:bais_mobile/features/home/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<NavigationController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.currentIndex.value == 0 ||
                controller.currentIndex.value == 1 ||
                controller.currentIndex.value == 3
            ? AppTheme.primary
            : AppTheme.background,
        body: SafeArea(
          child: IndexedStack(
            index: controller.currentIndex.value,
            children: [
              controller.currentIndex.value == 0 ? const DashboardView() : Container(),
              controller.currentIndex.value == 1 ? const HistoryReportView() : Container(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationWidget(),
      ),
    );
  }
}
