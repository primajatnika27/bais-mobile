import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/empty_list_widget.dart';
import 'package:bais_mobile/features/task/controllers/create_task_controller.dart';
import 'package:bais_mobile/features/task/widgets/task_card.dart';
import 'package:bais_mobile/features/task/widgets/task_filter_badge_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskView extends GetView<CreateTaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateTaskController());
    controller.fetchTasks(controller.filterType.value);

    return Scaffold(
      appBar: const AppBarGeneral(
        title: 'Task',
        withLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            const TaskFilterBadgeList(),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () {
                  return controller.tasks.isEmpty
                      ? _emptyWidget()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          itemCount: controller.tasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              onTap: () {
                                Get.toNamed(
                                  Routes.taskDetail,
                                  arguments: controller.tasks[index],
                                );
                              },
                              data: controller.tasks[index],
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyWidget() {
    return const EmptyListWidget(
      image: 'assets/images/ic_empty.png',
      title: "No task found",
      subtitle: "It seems you don't have any task yet.",
    );
  }
}
