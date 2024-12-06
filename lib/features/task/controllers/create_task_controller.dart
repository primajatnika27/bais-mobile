import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/constants/key_constant.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/services/shared_preference_service.dart';
import 'package:bais_mobile/core/widgets/file_section_input.dart';
import 'package:bais_mobile/core/widgets/photo_section_input.dart';
import 'package:bais_mobile/data/models/task_model.dart';
import 'package:bais_mobile/data/repositories/storage_repository.dart';
import 'package:bais_mobile/data/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CreateTaskController extends GetxController {
  var logger = Logger();
  final SharedPreferenceService prefs = Get.find<SharedPreferenceService>();
  final TaskRepository _taskRepository = TaskRepository();
  final StorageRepository _storageRepository = StorageRepository();

  // Text Controller
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskResultController = TextEditingController();
  final Rx<PhotoSectionInputModel> taskImage =
      PhotoSectionInputModel(nameId: "TASK_IMAGE").obs;
  final Rx<FileSectionInputModel> taskFile =
      FileSectionInputModel(nameId: "TASK_FILE").obs;

  RxString filterType = FilterTaskType.all.obs;
  final Rx<int> selectedFilter = 0.obs;
  var tasks = <TaskModel?>[].obs;
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    onGetTasks(filterType.value);
  }

  @override
  Future<void> refresh() async {
    onGetTasks(filterType.value);
    super.refresh();
  }

  @override
  void onClose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    taskResultController.dispose();
    super.onClose();
  }

  void showLoadingPopup() {
    GeneralDialog.showLoadingDialog();
  }

  void onGetTasks(String filterType) async {
    loading.value = true;
    String? id = prefs.getValue('userId');
    List<TaskModel> response = await _taskRepository.getListTaskById(id!);
    tasks.value = response
        .map((doc) {
          TaskModel task = doc;
          if (filterType == "All" || task.status == filterType) {
            return task;
          }
          return null;
        })
        .whereType<TaskModel>()
        .toList();
    loading.value = false;
  }

  void updateFilter(int filterIndex) {
    selectedFilter.value = filterIndex;

    List<String> filterTypes = [
      FilterTaskType.all,
      FilterTaskType.newTask,
      FilterTaskType.onGoing,
      FilterTaskType.submitted,
      FilterTaskType.completed,
      FilterTaskType.rejected,
    ];

    if (filterIndex >= 0 && filterIndex < filterTypes.length) {
      filterType.value = filterTypes[filterIndex];
      onGetTasks(filterType.value);
    }
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    try {
      await _taskRepository.updateTask(updatedTask);

      GeneralDialog.showSnackBar(ContentType.success, 'Update', 'Task updated');
      onGetTasks(filterType.value);
    } catch (e) {
      logger.e(e);
      GeneralDialog.showSnackBar(ContentType.failure, 'Error', e.toString());
    }
  }

  Future<void> downloadFile(String fileName) async {
    var response = await _storageRepository.downloadFile(fileName);

    if (response.statusCode == 200) {
      GeneralDialog.showSnackBar(
          ContentType.success, 'Download', 'File downloaded');
    }
  }

  Future<void> updateTaskWithUpload(
    TaskModel updatedTask,
    String title,
    String description,
    PhotoSectionInputModel taskImage,
    FileSectionInputModel taskFile,
  ) async {
    showLoadingPopup();
    try {
      var imagePath =
          await _storageRepository.uploadFile(taskImage.selectedImagePath!);
      var filePath =
          await _storageRepository.uploadFile(taskFile.selectedFilePath!);

      final data = Result(
        title: title,
        result: taskResultController.text,
        image: imagePath,
        file: filePath,
      );

      updatedTask.result?.add(data);
      logger.d(updatedTask.toJson());
      await _taskRepository.updateTask(updatedTask);

      GeneralDialog.showSnackBar(ContentType.success, 'Update', 'Task updated');
      Get.offAndToNamed(Routes.home);

      onGetTasks(filterType.value);
    } catch (e) {
      logger.e(e);
      GeneralDialog.showSnackBar(ContentType.failure, 'Error', e.toString());
    }
  }
}
