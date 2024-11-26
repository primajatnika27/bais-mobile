import 'package:bais_mobile/features/auth/registration/bindings/registration_binding.dart';
import 'package:bais_mobile/features/auth/registration/views/registration_success_view.dart';
import 'package:bais_mobile/features/auth/registration/views/registration_view.dart';
import 'package:bais_mobile/features/auth/signIn/bindings/signin_binding.dart';
import 'package:bais_mobile/features/auth/signIn/views/signin_view.dart';
import 'package:bais_mobile/features/chat_bot/bindings/chat_bot_binding.dart';
import 'package:bais_mobile/features/chat_bot/views/chat_bot_view.dart';
import 'package:bais_mobile/features/history_report/bindings/create_history_report_binding.dart';
import 'package:bais_mobile/features/history_report/views/history_report_view.dart';
import 'package:bais_mobile/features/home/bindings/home_binding.dart';
import 'package:bais_mobile/features/home/views/home_view.dart';
import 'package:bais_mobile/features/incident_report/bindings/incident_report_binding.dart';
import 'package:bais_mobile/features/incident_report/views/incident_report_form/incident_report_success_view.dart';
import 'package:bais_mobile/features/incident_report/views/incident_report_form/incident_report_view.dart';
import 'package:bais_mobile/features/incident_report/views/monthly_report_form/monthly_report_view.dart';
import 'package:bais_mobile/features/incident_report/views/report_landing_page_view.dart';
import 'package:bais_mobile/features/incident_report/views/weekly_report_form/weekly_report_view.dart';
import 'package:bais_mobile/features/incident_report/widgets/incident_map.dart';
import 'package:bais_mobile/features/profile/bindings/profile_binding.dart';
import 'package:bais_mobile/features/profile/views/profile_view.dart';
import 'package:bais_mobile/features/task/bindings/create_task_binding.dart';
import 'package:bais_mobile/features/task/views/task_detail_view.dart';
import 'package:bais_mobile/features/task/views/task_form_view.dart';
import 'package:bais_mobile/features/video_stream/bindings/video_stream_binding.dart';
import 'package:bais_mobile/features/video_stream/views/video_stream_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Routes {
  static const String signIn = '/sign-in';
  static const String register = '/register';
  static const String registerSuccess = '/register-success';
  static const String home = '/home';
  static const String chatBot = '/chat-bot';

  static const String profile = '/profile';

  static const String reportLanding = '/lading-page-report';
  static const String incidentReport = '/incident-report';
  static const String incidentReportMaps = '/incident-report-maps';
  static const String incidentReportSuccess = '/incident-report-success';
  static const String incidentReportHistory = '/incident-report-history';

  static const String weeklyReport = '/weekly-report';
  static const String monthlyReport = '/monthly-report';

  static const String task = '/task';
  static const String taskDetail = '/task-detail';
  static const String taskForm = '/task-form';

  static const String videoStream = '/video-stream';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.registerSuccess,
      page: () => const RegistrationSuccessView(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.chatBot,
      page: () => const ChatBotView(),
      binding: ChatBotBinding(),
    ),
    GetPage(
      name: Routes.reportLanding,
      page: () => const ReportLandingPageView(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: Routes.incidentReport,
      page: () => const IncidentReportView(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: Routes.weeklyReport,
      page: () => const WeeklyReportView(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: Routes.monthlyReport,
      page: () => const MonthlyReportView(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: Routes.incidentReportMaps,
      page: () => const IncidentMap(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: Routes.incidentReportSuccess,
      page: () => const IncidentReportSuccessView(),
    ),
    GetPage(
      name: Routes.incidentReportHistory,
      page: () => const HistoryReportView(),
      binding: CreateHistoryReportBinding(),
    ),
    GetPage(
      name: Routes.taskDetail,
      page: () => const TaskDetailView(),
      binding: CreateTaskBinding(),
    ),
    GetPage(
      name: Routes.taskForm,
      page: () => const TaskFormView(),
      binding: CreateTaskBinding(),
    ),
    GetPage(
      name: Routes.videoStream,
      page: () => const VideoStreamView(),
      binding: VideoStreamBinding(),
    ),
  ];

  static Future<String> get initialRoute async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('initial-route') ?? Routes.signIn;
  }

  static setInitialRoute(String route) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('initial-route', route);
  }
}
