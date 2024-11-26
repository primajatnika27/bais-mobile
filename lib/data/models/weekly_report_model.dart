abstract class Report {
  Map<String, dynamic> toJson();
}

class WeeklyReportModel extends Report {
  String? userId;
  String? title;
  int? totalIncident;
  String? description;
  String? reportStartDate;
  String? reportEndDate;
  String? reportType;
  String? reporterName;
  String? operationType;

  WeeklyReportModel({
    this.userId,
    this.title,
    this.totalIncident,
    this.description,
    this.reportStartDate,
    this.reportEndDate,
    this.reportType,
    this.reporterName,
    this.operationType
  });

  @override
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'title': title,
    'total_incident': totalIncident,
    'description': description,
    'report_start_date': reportStartDate,
    'report_end_date': reportEndDate,
    'report_type': reportType,
    'reporter_name': reporterName,
    'operation_type': operationType
  };

  factory WeeklyReportModel.fromJson(Map<String, dynamic> json) {
    return WeeklyReportModel(
      userId: json['user_id'],
      title: json['title'],
      totalIncident: json['total_incident'],
      description: json['description'],
      reportStartDate: json['report_start_date'],
      reportEndDate: json['report_end_date'],
      reportType: json['report_type'],
      reporterName: json['reporter_name'],
      operationType: json['operation_type']
    );
  }
}