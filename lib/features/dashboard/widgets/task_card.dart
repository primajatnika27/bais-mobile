import 'package:bais_mobile/core/helpers/utils/color_extensions.dart';
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
                  svgPath: "assets/icons/ic_checklist.svg",
                  color: const Color(0xFFECF9EB),
                  bgColor: HexColor('#D398E74D'),
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.onGoingTaskTotal.value.toString(),
                  title: "On Going",
                  svgPath: "assets/icons/ic_checklist.svg",
                  color: const Color(0xFFFDF5E6),
                  bgColor: HexColor('#F0C2744D'),
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.submittedTaskTotal.value.toString(),
                  title: "Submitted",
                  svgPath: "assets/icons/ic_checklist.svg",
                  color: const Color(0xFFECF9EB),
                  bgColor: HexColor('#70A1E54D'),
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.submittedTaskTotal.value.toString(),
                  title: "Submitted",
                  svgPath: "assets/icons/ic_checklist.svg",
                  color: const Color(0xFFFDEBEC),
                  bgColor: HexColor('#32913F4D'),
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.rejectedTaskTotal.value.toString(),
                  title: "Reject",
                  svgPath: "assets/icons/ic_checklist.svg",
                  color: const Color(0xFFFDEBEC),
                  bgColor: HexColor('#F0C2744D'),
                  onPressed: () {},
                ),
                TaskItemWidget(
                  value: controller.completedTaskTotal.value.toString(),
                  title: "Complete",
                  svgPath: "assets/icons/ic_checklist.svg",
                  color: const Color(0xFFFDEBEC),
                  bgColor: HexColor('#70A1E54D'),
                  onPressed: () {},
                ),
              ]);
        }),
      ],
    );
  }
}
