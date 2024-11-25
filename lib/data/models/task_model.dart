abstract class Task {
  Map<String, dynamic> toJson();
}

class TaskModel {
  String? id;
  String? title;
  String? reportTitle;
  String? description;
  String? address;
  String? result;
  Map<String, dynamic>? assigned;
  String? startDate;
  String? endDate;
  String? status;

  TaskModel({
    this.id,
    this.title,
    this.reportTitle,
    this.description,
    this.address,
    this.result,
    this.assigned,
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
      'address': address,
      'result': result,
      'assigned': assigned,
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
      address: json['address'],
      result: json['result'],
      assigned: json['assigned'],
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
      address: data['address'],
      result: data['task_result'],
      assigned: data['assigned'],
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
      'address': address,
      'task_result': result,
      'assigned': assigned,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
    };
  }
}
