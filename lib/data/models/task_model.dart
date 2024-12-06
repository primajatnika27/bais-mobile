import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str), '');

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? id;
  String? taskTitle;
  String? taskDescription;
  String? address;
  Assigned? assigned;
  String? startDate;
  double? latitude;
  double? longitude;
  String? endDate;
  String? status;
  List<Result>? result;

  TaskModel({
    this.id,
    this.taskTitle,
    this.taskDescription,
    this.address,
    this.assigned,
    this.startDate,
    this.latitude,
    this.longitude,
    this.endDate,
    this.status,
    this.result,
  });

  TaskModel copyWith({
    String? id,
    String? taskTitle,
    String? taskDescription,
    String? address,
    Assigned? assigned,
    String? startDate,
    double? latitude,
    double? longitude,
    String? endDate,
    String? status,
    List<Result>? result,
  }) =>
      TaskModel(
        id: id ?? this.id,
        taskTitle: taskTitle ?? this.taskTitle,
        taskDescription: taskDescription ?? this.taskDescription,
        address: address ?? this.address,
        assigned: assigned ?? this.assigned,
        startDate: startDate ?? this.startDate,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        result: result ?? this.result,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json, String id) => TaskModel(
    id: id,
    taskTitle: json["task_title"],
    taskDescription: json["task_description"],
    address: json["address"],
    assigned: json["assigned"] == null ? null : Assigned.fromJson(json["assigned"]),
    startDate: json["start_date"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    endDate: json["end_date"],
    status: json["status"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_title": taskTitle,
    "task_description": taskDescription,
    "address": address,
    "assigned": assigned?.toJson(),
    "start_date": startDate,
    "latitude": latitude,
    "longitude": longitude,
    "end_date": endDate,
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Assigned {
  String? name;
  String? id;
  String? email;

  Assigned({
    this.name,
    this.id,
    this.email,
  });

  Assigned copyWith({
    String? name,
    String? id,
    String? email,
  }) =>
      Assigned(
        name: name ?? this.name,
        id: id ?? this.id,
        email: email ?? this.email,
      );

  factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(
    name: json["name"],
    id: json["id"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "email": email,
  };
}

class Result {
  String? title;
  String? result;
  String? image;
  String? file;

  Result({
    this.title,
    this.result,
    this.image,
    this.file,
  });

  Result copyWith({
    String? title,
    String? result,
    String? image,
    String? file,
  }) =>
      Result(
        title: title ?? this.title,
        result: result ?? this.result,
        image: image ?? this.image,
        file: file ?? this.file,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    title: json["title"],
    result: json["result"],
    image: json["image"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "result": result,
    "image": image,
    "file": file,
  };
}
