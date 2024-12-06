import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:bais_mobile/data/providers/reports_provider.dart';
import 'package:bais_mobile/services/http_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsRepository {
  late final ReportsProvider _provider;

  ReportsRepository() {
    final fireStore = FirebaseFirestore.instance;
    final httpService = HttpService(baseUrl: '');
    _provider = ReportsProvider(fireStore, httpService);
  }

  Future<List<TaskReportModel>> getDailyReportById(String id) async {
    return await _provider.getDailyReportById(id);
  }

  Future addIncident(TaskReportModel report) async {
    return await _provider.addIncident(report);
  }

  Future addReport(dynamic report) async {
    return await _provider.addIncident(report);
  }
}
