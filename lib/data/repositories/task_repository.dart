import 'package:bais_mobile/data/models/task_model.dart';
import 'package:bais_mobile/data/providers/task_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskRepository {
  late final TaskProvider _provider;

  TaskRepository() {
    final fireStore = FirebaseFirestore.instance;
    _provider = TaskProvider(fireStore);
  }

  Future<List<TaskModel>> getListTaskById(String id) =>
      _provider.getListTaskById(id);

  Future updateTask(TaskModel updatedTask) =>
      _provider.putTaskById(updatedTask);
}
