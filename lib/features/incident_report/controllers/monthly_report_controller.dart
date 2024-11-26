import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/dialogs/general_dialogs.dart';
import 'package:bais_mobile/core/themes/app_theme.dart';
import 'package:bais_mobile/core/widgets/dropdown_input.dart';
import 'package:bais_mobile/data/models/weekly_report_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MonthlyReportController extends GetxController {
  // Firebase FireStore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController totalIncidentController = TextEditingController();
  final TextEditingController reporterNameController = TextEditingController();
  final DropdownController<String> operationTypeController =
  DropdownController<String>();

  final TextEditingController titleReportController = TextEditingController();
  final TextEditingController descriptionReportController = TextEditingController();

  var usersId = "".obs;

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
    getUserData();
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
    showLoadingPopup();
    payload.userId = usersId.value;
    payload.reporterName = reporterNameController.text;
    payload.operationType = operationTypeController.selectedValue.value;
    payload.title = titleReportController.text;
    payload.description = descriptionReportController.text;
    payload.reportStartDate = startDateController.text;
    payload.reportEndDate = endDateController.text;
    payload.totalIncident = int.parse(totalIncidentController.text);
    payload.reportType = 'Monthly';

    await _fireStore.collection('reports').add(payload.toJson());
    Get.snackbar(
      'Success',
      'Weekly Report has been submitted',
      backgroundColor: AppTheme.green500,
      colorText: Colors.white,
    );

    Get.toNamed(Routes.incidentReportSuccess);
  }

  DateTime parseDate(String dateString) {
    // Assuming the format is "27 November 2024"
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

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersId.value = prefs.getString('userId') ?? '';
  }
}