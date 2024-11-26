import 'package:bais_mobile/features/incident_report/controllers/incident_report_controller.dart';
import 'package:bais_mobile/features/incident_report/controllers/monthly_report_controller.dart';
import 'package:bais_mobile/features/incident_report/controllers/report_landing_page_controller.dart';
import 'package:bais_mobile/features/incident_report/controllers/weekly_report_controller.dart';
import 'package:get/get.dart';

class IncidentReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IncidentReportController>(() => IncidentReportController());
    Get.lazyPut<ReportLandingPageController>(() => ReportLandingPageController());
    Get.lazyPut<WeeklyReportController>(() => WeeklyReportController());
    Get.lazyPut<MonthlyReportController>(() => MonthlyReportController());
  }
}