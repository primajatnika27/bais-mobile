import 'dart:convert';

import 'package:bais_mobile/core/helpers/database_helper.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateHistoryReportController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  var taskReports = <TaskReportModel>[].obs;

  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// Dashboard Data
  var lastTimeIncidentTotal = 0.obs;
  var medicalTreatmentTotal = 0.obs;
  var minorIncidentTotal = 0.obs;
  var nearMissTotal = 0.obs;
  var potentialHazardTotal = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getLocalData();
  }

  void getLocalData() async {
    print("Loading data from Firestore");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId') ?? '';
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await _fireStore
          .collection('incident')
          .where('user_id', isEqualTo: userId)
          .get();

      // Map the documents to TaskReportModel
      taskReports.value = snapshot.docs.map((doc) {
        return TaskReportModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      // Calculate totals for different incident types
      lastTimeIncidentTotal.value = taskReports
          .where((element) => element.incidentType == "Last Time Incident")
          .length;
      medicalTreatmentTotal.value = taskReports
          .where((element) => element.incidentType == "Medical Incident")
          .length;
      minorIncidentTotal.value = taskReports
          .where((element) => element.incidentType == "Minor Incident")
          .length;
      nearMissTotal.value = taskReports
          .where((element) => element.incidentType == "Near Miss")
          .length;
      potentialHazardTotal.value = taskReports
          .where((element) => element.incidentType == "Potential Hazard")
          .length;
    } catch (e) {
      print("Error fetching data from Firestore: $e");
    }
  }
}