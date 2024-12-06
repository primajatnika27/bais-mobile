import 'package:bais_mobile/core/services/shared_preference_service.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:bais_mobile/data/repositories/reports_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ReportLandingPageController extends GetxController {
  var logger = Logger();
  final SharedPreferenceService prefs = Get.find<SharedPreferenceService>();
  final ReportsRepository _reportsRepository = ReportsRepository();

  var taskReports = <TaskReportModel>[].obs;

  var medicalTreatmentTotal = 0.obs;
  var minorIncidentTotal = 0.obs;
  var nearMissTotal = 0.obs;
  var potentialHazardTotal = 0.obs;

  @override
  void onInit() {
    onGetChartData();
    super.onInit();
  }

  void onGetChartData() async {
    try {
      String? id = prefs.getValue('userId');
      List<TaskReportModel> response = await _reportsRepository.getDailyReportById(id!);
      logger.d(id);
      logger.d(response.length);

      taskReports.value = response;
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
      logger.e(e);
    }
  }
}
