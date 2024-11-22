import 'dart:convert';

import 'package:bais_mobile/core/helpers/database_helper.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateHistoryReportController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var taskReports = <TaskReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLocalData();
  }

  void getLocalData() async {
    print("Loading local data");
    List<String> data = await _dbHelper.getAllTaskReport();
    taskReports.value = data.map((jsonString) {
      return TaskReportModel.fromJson(jsonDecode(jsonString));
    }).toList();
  }
}