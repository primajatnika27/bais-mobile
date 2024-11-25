import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/info_card.dart';
import 'package:bais_mobile/data/models/task_model.dart';
import 'package:bais_mobile/features/task/controllers/create_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TaskDetailView extends GetView<CreateTaskController> {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    TaskModel task = Get.arguments;

    return Scaffold(
      appBar: AppBarGeneral(
        title: 'Task Detail',
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CardWrapperWidget(
            title: 'Task ID:  ${task.id}',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  detailInfo(
                    'Task Name',
                    task.title ?? '',
                    isHighlighted: true,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppTheme.secondary250,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InfoCard(
                        text: task.address ?? '',
                        borderColor: AppTheme.primary,
                        backgroundColor: AppTheme.red100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  detailInfo(
                    'Description',
                    task.description ?? '',
                  ),
                  detailInfo(
                    'Status',
                    task.status ?? '',
                    isHighlighted: true,
                  ),
                  detailInfo(
                    'Assigned To',
                    task.assigned?['name'] ?? '',
                  ),
                  detailInfo(
                    'Start Date',
                    task.startDate ?? '',
                  ),
                  detailInfo(
                    'End Date',
                    task.endDate ?? '',
                  ),
                  task.status == 'Submitted' ||
                          task.status == 'Completed' ||
                          task.status == 'Rejected'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Result',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppTheme.secondary250,
                              ),
                            ),
                            const SizedBox(height: 8),
                            InfoCard(text: task.result ?? ''),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: task.status == 'Submitted' ||
              task.status == 'Completed'
          ? const SizedBox.shrink()
          : SafeArea(
              child: BottomButtonWidget(
                title: task.status != 'New Task' ? 'Add Report' : "Accept Task",
                onTap: task.status != 'New Task'
                    ? () {
                        Get.toNamed(Routes.taskForm, arguments: task);
                      }
                    : () {
                        final updatedTask = TaskModel(
                          id: task.id,
                          title: task.title,
                          description: task.description,
                          assigned: task.assigned,
                          startDate: task.startDate,
                          endDate: task.endDate,
                          address: task.address,
                          status: 'On Going',
                        );

                        controller.updateTask(task.id!, updatedTask);
                        Get.back();
                      },
              ),
            ),
    );
  }

  Widget detailInfo(
    String title,
    String value, {
    bool isHighlighted = false,
    bool canCopy = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppTheme.secondary250,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isHighlighted
                          ? AppTheme.primary
                          : AppTheme.secondary800,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                if (canCopy) // Add copy button conditionally
                  IconButton(
                    constraints: const BoxConstraints(maxWidth: 20),
                    icon: const Icon(Icons.copy,
                        color: AppTheme.primary, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: value));
                      // Optional: Add feedback
                      print('Copied to clipboard: $value');
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
