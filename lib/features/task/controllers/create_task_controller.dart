import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateTaskController extends GetxController {
  var tasks = <TaskModel?>[].obs;

  // Text Controller
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskResultController = TextEditingController();

  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  RxString filterType = 'All'.obs;
  final Rx<int> selectedFilter = 0.obs;

  void updateFilter(int filterIndex) {
    selectedFilter.value = filterIndex;

    switch (filterIndex) {
      case 0:
        filterType.value = 'All';
        break;
      case 1:
        filterType.value = 'New Task';
        break;
      case 2:
        filterType.value = 'On Going';
        break;
      case 3:
        filterType.value = 'Submitted';
        break;
      case 4:
        filterType.value = 'Completed';
        break;
      case 5:
        filterType.value = 'Rejected';
        break;
    }

    fetchTasks(filterType.value);
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks(filterType.value);
  }

  void fetchTasks(String filterType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('userEmail');

    print(email);

    _fireStore
        .collection('tasks')
        .where('assigned.email', isEqualTo: email)
        .snapshots()
        .listen(
      (snapshot) {
        print("=========== SNAPSHOTS DATA TASK ===========");
        print(snapshot.docs.length);
        tasks.value = snapshot.docs
            .map((doc) {
              TaskModel task = TaskModel.fromMap(doc.data(), doc.id);
              // Check if filterType is "All" or matches the task status
              if (filterType == "All" || task.status == filterType) {
                return task;
              }
              return null;
            })
            .whereType<TaskModel>()
            .toList();
      },
    );
  }

  Future<void> updateTask(String taskId, TaskModel updatedTask) async {
    try {
      await _fireStore
          .collection('tasks')
          .doc(taskId)
          .update(updatedTask.toMap());
      Get.snackbar(
        'Success',
        'Task updated successfully',
        backgroundColor: AppTheme.green500,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update task: $e',
        backgroundColor: AppTheme.red500,
        colorText: Colors.white,
      );
    }
  }
}
