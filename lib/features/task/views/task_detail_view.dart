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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CardWrapperWidget(
              title: 'Task ID:  ${task.id}',
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    detailInfo(
                      'Task Name',
                      task.taskTitle ?? '',
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
                      task.taskDescription ?? '',
                    ),
                    detailInfo(
                      'Status',
                      task.status ?? '',
                      isHighlighted: true,
                    ),
                    detailInfo(
                      'Assigned To',
                      task.assigned?.name ?? '',
                    ),
                    detailInfo(
                      'Start Date',
                      task.startDate ?? '',
                    ),
                    detailInfo(
                      'End Date',
                      task.endDate ?? '',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CardWrapperWidget(
              title: 'Result',
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: task.result?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Result ${index + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.secondary250,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InfoCard(
                            text: task.result?[index].title ?? '',
                            borderColor: AppTheme.primary,
                            backgroundColor: AppTheme.red100,
                          ),
                          const SizedBox(height: 16),
                          detailInfo(
                            'Description',
                            task.result?[index].result ?? '',
                          ),
                          detailInfo(
                              'Document',
                              isLink: true,
                              task.result?[index].file ?? '', onDownload: () {
                                print("Download Document");
                            controller
                                .downloadFile(task.result?[index].file ?? '');
                          }),
                          detailInfo(
                              'Photo',
                              isLink: true,
                              task.result?[index].image ?? '', onDownload: () {
                            print("Download File");
                            controller
                                .downloadFile(task.result?[index].image ?? '');
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          task.status == 'Submitted' || task.status == 'Completed'
              ? const SizedBox.shrink()
              : SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: BottomButtonWidget(
                          title: task.status != 'New Task'
                              ? 'Update Report'
                              : "Accept Task",
                          onTap: task.status != 'New Task'
                              ? () {
                                  Get.toNamed(Routes.taskForm, arguments: task);
                                }
                              : () {
                                  final updatedTask =
                                      task.copyWith(status: 'On Going');
                                  controller.updateTask(updatedTask);
                                  Get.back();
                                },
                        ),
                      ),
                      task.status != 'New Task' ? Expanded(
                        child: BottomButtonWidget(
                          title: "Finish Task",
                          fillColor: AppTheme.lightPrimary,
                          onTap: () {
                            final updatedTask = task.copyWith(status: 'Submitted');
                            controller.updateTask(updatedTask);
                            Get.back();
                          },
                        ),
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                ),
    );
  }

  Widget detailInfo(
    String title,
    String value, {
    bool isHighlighted = false,
    bool isLink = false,
    bool canCopy = false,
    VoidCallback? onDownload,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      !isLink ? Flexible(
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
                      ) : const SizedBox(),
                      isLink ? const Spacer() : const SizedBox(),
                      isLink
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: onDownload,
                              child: const Icon(
                                Icons.download,
                                color: AppTheme.white,
                              ),
                            )
                          : Container(),
                    ],
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
