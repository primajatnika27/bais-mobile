import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/text_area_input.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/data/models/task_model.dart';
import 'package:bais_mobile/features/task/controllers/create_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskFormView extends GetView<CreateTaskController> {
  const TaskFormView({super.key});

  @override
  Widget build(BuildContext context) {
    TaskModel task = Get.arguments;

    controller.taskTitleController.text = task.reportTitle ?? '';
    controller.taskResultController.text = task.result ?? '';

    return Scaffold(
      appBar: AppBarGeneral(
        title: 'Task Form',
        onTapLeading: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CardWrapperWidget(
            title: 'Update Task',
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFieldWidget(
                    title: 'Task Title',
                    placeholder: 'ex: task name',
                    controller: controller.taskTitleController,
                  ),
                  const SizedBox(height: 16),
                  TextAreaInput(
                    title: 'Result Answer',
                    placeholder: 'ex: result',
                    controller: controller.taskResultController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomButtonWidget(
          title: 'Send',
          onTap: () {
            final updatedTask = TaskModel(
              id: task.id,
              title: task.title,
              reportTitle: controller.taskTitleController.text,
              description: task.description,
              assignedTo: task.assignedTo,
              startDate: task.startDate,
              endDate: task.endDate,
              result: controller.taskResultController.text,
              status: 'Submitted',
            );

            controller.updateTask(task.id!, updatedTask);
            Get.offAndToNamed(Routes.home);
          },
        ),
      ),
    );
  }
}
