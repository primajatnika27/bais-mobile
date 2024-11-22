class TaskReportFormData {
  final String payload;

  TaskReportFormData({
    this.payload = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'payload': payload,
    };
  }
}