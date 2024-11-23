import 'package:bais_mobile/core/widgets/filter_badge_widget.dart';
import 'package:bais_mobile/features/task/controllers/create_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskFilterBadgeList extends StatelessWidget {
  const TaskFilterBadgeList({super.key});

  @override
  Widget build(BuildContext context) {
    CreateTaskController controller = Get.find<CreateTaskController>();
    final List<String> filters = [
      "All",
      "New Task",
      "On Going",
      "Submitted",
      "Completed",
    ];

    return SizedBox(
      height: 34,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 4.0,
              right: index == 4 ? 16 : 4.0,
            ),
            child: Obx(() => FilterBadge(
              label: filters[index],
              isSelected: index == controller.selectedFilter.value,
              onTap: () {
                controller.updateFilter(index);
              },
            )),
          );
        },
      ),
    );
  }
}
