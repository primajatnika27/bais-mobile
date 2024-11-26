abstract class Report {
  Map<String, dynamic> toJson();
}

class TaskReportModel extends Report {
  String? userId;
  String? incidentType;
  String? incidentLevel;
  String? reporterName;
  String? incidentDate;
  String? incidentTime;
  String? incidentDescription;
  String? incidentPhotoPath;
  double? incidentLocationLat;
  double? incidentLocationLng;
  String? incidentLocationAddress;

  TaskReportModel({
    this.userId,
    this.incidentType,
    this.incidentLevel,
    this.reporterName,
    this.incidentDate,
    this.incidentTime,
    this.incidentDescription,
    this.incidentPhotoPath,
    this.incidentLocationLat,
    this.incidentLocationLng,
    this.incidentLocationAddress,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'incident_type': incidentType,
      'incident_level': incidentLevel,
      'reporter_name': reporterName,
      'incident_date': incidentDate,
      'incident_time': incidentTime,
      'incident_description': incidentDescription,
      'incident_photo_path': incidentPhotoPath,
      'incident_location_lat': incidentLocationLat,
      'incident_location_lng': incidentLocationLng,
      'incident_location_address': incidentLocationAddress,
    };
  }

  factory TaskReportModel.fromJson(Map<String, dynamic> json) {
    return TaskReportModel(
      userId: json['user_id'],
      incidentType: json['incident_type'],
      incidentLevel: json['incident_level'],
      reporterName: json['reporter_name'],
      incidentDate: json['incident_date'],
      incidentTime: json['incident_time'],
      incidentDescription: json['incident_description'],
      incidentPhotoPath: json['incident_photo_path'],
      incidentLocationLat: json['incident_location_lat'],
      incidentLocationLng: json['incident_location_lng'],
      incidentLocationAddress: json['incident_location_address'],
    );
  }
}