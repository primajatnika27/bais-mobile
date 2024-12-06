import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/services/shared_preference_service.dart';
import 'package:bais_mobile/core/widgets/dropdown_input.dart';
import 'package:bais_mobile/data/models/weekly_report_model.dart';
import 'package:bais_mobile/data/repositories/reports_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyReportController extends GetxController {
  final SharedPreferenceService prefs = Get.find<SharedPreferenceService>();
  final ReportsRepository _reportsRepository = ReportsRepository();

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController totalIncidentController = TextEditingController();
  final TextEditingController reporterNameController = TextEditingController();
  final DropdownController<String> operationTypeController =
      DropdownController<String>();

  final TextEditingController titleReportController = TextEditingController();
  final TextEditingController descriptionReportController =
      TextEditingController();

  /// Payload
  var payload = WeeklyReportModel();

  final List<String> operationType = [
    'Pengawasan',
    'Penyelidikan',
    'Pengumpulan Data',
  ];

  final endDateMax = DateTime.now().obs;

  final RxInt currentIndex = 0.obs;
  final RxList<String> tabs = [
    'Data',
    'Files',
  ].obs;

  @override
  void onInit() {
    operationTypeController.setItems(operationType);
    super.onInit();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void updateEndDateMax(DateTime maxDate) {
    endDateMax.value = maxDate;
  }

  void showLoadingPopup() {
    GeneralDialog.showLoadingDialog();
  }

  void onSubmitReport() async {
    String? id = prefs.getValue('userId');

    showLoadingPopup();
    payload.userId = id;
    payload.reporterName = reporterNameController.text;
    payload.operationType = operationTypeController.selectedValue.value;
    payload.title = titleReportController.text;
    payload.description = descriptionReportController.text;
    payload.reportStartDate = startDateController.text;
    payload.reportEndDate = endDateController.text;
    payload.totalIncident = int.parse(totalIncidentController.text);
    payload.reportType = 'Monthly';

    await _reportsRepository.addReport(payload);
    GeneralDialog.showSnackBar(
      ContentType.success,
      'Success',
      'Monthly Report has been submitted',
    );

    Get.toNamed(Routes.incidentReportSuccess);
  }

  DateTime parseDate(String dateString) {
    final parts = dateString.split(' ');
    final day = int.parse(parts[0]);
    final month = _monthStringToNumber(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  int _monthStringToNumber(String month) {
    switch (month.toLowerCase()) {
      case 'january':
        return 1;
      case 'february':
        return 2;
      case 'march':
        return 3;
      case 'april':
        return 4;
      case 'may':
        return 5;
      case 'june':
        return 6;
      case 'july':
        return 7;
      case 'august':
        return 8;
      case 'september':
        return 9;
      case 'october':
        return 10;
      case 'november':
        return 11;
      case 'december':
        return 12;
      default:
        throw ArgumentError('Invalid month string');
    }
  }
}
