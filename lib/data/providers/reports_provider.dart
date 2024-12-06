import 'package:bais_mobile/core/constants/key_constant.dart';
import 'package:bais_mobile/data/models/task_report_model.dart';
import 'package:bais_mobile/services/http_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsProvider {
  final FirebaseFirestore _fireStore;
  final HttpService _httpService;

  ReportsProvider(this._fireStore, this._httpService);

  Future<List<TaskReportModel>> getDailyReportById(String id) async {
    QuerySnapshot snapshot = await _fireStore
        .collection(TableCollection.incidents)
        .where('user_id', isEqualTo: id)
        .get();

    return snapshot.docs
        .map((doc) => TaskReportModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future addIncident(TaskReportModel report) async {
    await _fireStore
        .collection(TableCollection.incidents)
        .add(report.toJson());

    return;
  }

  Future addReport(dynamic report) async {
    await _fireStore
        .collection(TableCollection.reports)
        .add(report.toJson());

    return;
  }
}