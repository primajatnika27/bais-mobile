import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportLandingPageController extends GetxController {
  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  var taskReports = <TaskReportModel>[].obs;

  var medicalTreatmentTotal = 0.obs;
  var minorIncidentTotal = 0.obs;
  var nearMissTotal = 0.obs;
  var potentialHazardTotal = 0.obs;

  @override
  void onInit() {
    getChartData();
    super.onInit();
  }

  void getChartData() async {
    print("Loading chart data from Firestore");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId') ?? '';
    try {
      QuerySnapshot snapshot = await _fireStore
          .collection('incident')
          .where('user_id', isEqualTo: userId)
          .get();

      // Map the documents to TaskReportModel
      taskReports.value = snapshot.docs.map((doc) {
        return TaskReportModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

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
