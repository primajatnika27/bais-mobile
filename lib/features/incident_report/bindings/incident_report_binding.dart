import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:get/get.dart';

class IncidentReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncidentReportController>(() => IncidentReportController());
  }
}