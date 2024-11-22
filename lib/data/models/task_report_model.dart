abstract class Report {
  Map<String, dynamic> toJson();
}

class TaskReportModel extends Report {
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
      'incidentType': incidentType,
      'incidentLevel': incidentLevel,
      'reporterName': reporterName,
      'incidentDate': incidentDate,
      'incidentTime': incidentTime,
      'incidentDescription': incidentDescription,
      'incidentPhotoPath': incidentPhotoPath,
      'incidentLocationLat': incidentLocationLat,
      'incidentLocationLng': incidentLocationLng,
      'incidentLocationAddress': incidentLocationAddress,
    };
  }

  factory TaskReportModel.fromJson(Map<String, dynamic> json) {
    return TaskReportModel(
      incidentType: json['incidentType'],
      incidentLevel: json['incidentLevel'],
      reporterName: json['reporterName'],
      incidentDate: json['incidentDate'],
      incidentTime: json['incidentTime'],
      incidentDescription: json['incidentDescription'],
      incidentPhotoPath: json['incidentPhotoPath'],
      incidentLocationLat: json['incidentLocationLat'],
      incidentLocationLng: json['incidentLocationLng'],
      incidentLocationAddress: json['incidentLocationAddress'],
    );
  }
}