abstract class Task {
  Map<String, dynamic> toJson();
}

class TaskModel {
  String? id;
  String? title;
  String? reportTitle;
  String? description;
  String? result;
  String? assignedTo;
  String? startDate;
  String? endDate;
  String? status;

  TaskModel({
    this.id,
    this.title,
    this.reportTitle,
    this.description,
    this.result,
    this.assignedTo,
    this.startDate,
    this.endDate,
    this.status
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'reportTitle': reportTitle,
      'description': description,
      'result': result,
      'assignedTo': assignedTo,
      'startDate': startDate,
      'endDate': endDate,
      'status': status
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      reportTitle: json['reportTitle'],
      description: json['description'],
      result: json['result'],
      assignedTo: json['assignedTo'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status']
    );
  }

  // Parse FireStore DocumentSnapshot ke TaskModel
  factory TaskModel.fromMap(Map<String, dynamic> data, String documentId) {
    return TaskModel(
      id: documentId,
      title: data['task_title'],
      reportTitle: data['report_title'],
      description: data['task_description'],
      result: data['task_result'],
      assignedTo: data['assigned'],
      startDate: data['start_date'],
      endDate: data['end_date'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'task_title': title,
      'report_title': reportTitle,
      'task_description': description,
      'task_result': result,
      'assigned': assignedTo,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
    };
  }
}
