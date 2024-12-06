import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/widgets/app_bar_general.dart';
import 'package:bais_mobile/core/widgets/bottom_button_widget.dart';
import 'package:bais_mobile/core/widgets/card_wrapper_widget.dart';
import 'package:bais_mobile/core/widgets/file_section_input.dart';
import 'package:bais_mobile/core/widgets/photo_section_input.dart';
import 'package:bais_mobile/core/widgets/text_area_input.dart';
import 'package:bais_mobile/core/widgets/text_field_widget.dart';
import 'package:bais_mobile/data/models/task_model.dart';
import 'package:bais_mobile/features/task/controllers/create_task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskFormView extends GetView<CreateTaskController> {
  TaskFormView({super.key}) : cameraImagePath = Rxn<String>();

  final Rxn<String> cameraImagePath;

  void setCameraImagePath(String? path) {
    cameraImagePath.value = path;
  }

  @override
  Widget build(BuildContext context) {
    TaskModel task = Get.arguments;
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
                  const SizedBox(height: 16),
                  PhotoSectionInput(
                    title: 'Pick Photo',
                    sampleText: 'ex: Task photo',
                    inputModel: controller.taskImage,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  FileSectionInput(
                    title: 'Pick File',
                    inputModel: controller.taskFile,
                    isRequired: true,
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
            final updatedTask = task.copyWith();
            controller.updateTaskWithUpload(
              updatedTask,
              controller.taskTitleController.text,
              controller.taskResultController.text,
              controller.taskImage.value,
              controller.taskFile.value,
            );
          },
        ),
      ),
    );
  }
}
