import 'package:bais_mobile/features/history_report/controllers/create_history_report_controller.dart';
import 'package:get/get.dart';

class CreateHistoryReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateHistoryReportController());
  }
}