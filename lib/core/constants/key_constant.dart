abstract class SessionKeys {
  static const String user = 'userData';
  static const String token = 'token';
  static const String firebaseToken = 'firebase_token';
  static const String isLogin = 'isLogin';
  static const String database = 'database';
  static const String accountHolder = 'account_holder';
  static const String bluetooth = "bluetooth";
}

abstract class APIResult {
  static const int success = 200;
  static const int failed = 404;
  static const int invalid = 401;
}

abstract class TableCollection {
  static const String users = 'users';
  static const String task = 'tasks';
  static const String incidents = 'incident';
  static const String reports = 'reports';
}

abstract class FilterTaskType {
  static const String all = 'All';
  static const String newTask = 'New Task';
  static const String onGoing = 'On Going';
  static const String submitted = 'Submitted';
  static const String completed = 'Completed';
  static const String rejected = 'Rejected';
}
