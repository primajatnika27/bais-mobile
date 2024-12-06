import 'package:bais_mobile/core/constants/key_constant.dart';
import 'package:bais_mobile/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskProvider {
  final FirebaseFirestore _fireStore;

  TaskProvider(this._fireStore);

  Future<List<TaskModel>> getListTaskById(String id) async {
    QuerySnapshot snapshot = await _fireStore
        .collection(TableCollection.task)
        .where('assigned.id', isEqualTo: id)
        .get();

    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs
        .map(
          (doc) =>
              TaskModel.fromJson(doc.data() as Map<String, dynamic>, doc.id),
        )
        .toList();
  }

  Future putTaskById(TaskModel task) async {
    await _fireStore
        .collection(TableCollection.task)
        .doc(task.id)
        .set(task.toJson());

    return;
  }
}
