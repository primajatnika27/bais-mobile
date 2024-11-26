import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/features/dashboard/controllers/dashboard_controller.dart';
import 'package:bais_mobile/features/dashboard/widgets/task_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCard extends GetView<DashboardController> {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Obx(() {
          return GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 16 / 10,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              shrinkWrap: true,
              children: [
                TaskItemWidget(
                  value: controller.newTaskTotal.value.toString(),
                  title: "New Task",
                  svgPath: "assets/icons/ic_new.png",
                  color: const Color(0xFFECF9EB),
                  bgColor: AppTheme.red100,
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.onGoingTaskTotal.value.toString(),
                  title: "On Going",
                  svgPath: "assets/icons/ic_ongoing.png",
                  color: const Color(0xFFFDF5E6),
                  bgColor: AppTheme.secondary100,
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.submittedTaskTotal.value.toString(),
                  title: "Submitted",
                  svgPath: "assets/icons/ic_submitted.png",
                  color: const Color(0xFFECF9EB),
                  bgColor: AppTheme.blue100,
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.rejectedTaskTotal.value.toString(),
                  title: "Reject",
                  svgPath: "assets/icons/ic_reject.png",
                  color: const Color(0xFFFDEBEC),
                  bgColor: AppTheme.green100,
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.completedTaskTotal.value.toString(),
                  title: "Complete",
                  svgPath: "assets/icons/ic_complete.png",
                  color: const Color(0xFFFDEBEC),
                  bgColor: AppTheme.orange100,
                  onPressed: () {},
                ),
              ]);
        }),
      ],
    );
  }
}
