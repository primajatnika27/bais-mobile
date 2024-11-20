import 'package:bais_mobile/features/auth/signIn/bindings/signin_binding.dart';
import 'package:bais_mobile/features/auth/signIn/views/signin_view.dart';
import 'package:bais_mobile/features/home/bindings/home_binding.dart';
import 'package:bais_mobile/features/home/views/home_view.dart';
import 'package:bais_mobile/features/incident_report/bindings/incident_report_binding.dart';
import 'package:bais_mobile/features/incident_report/views/incident_report_view.dart';
import 'package:bais_mobile/features/incident_report/widgets/incident_map.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Routes {
  static const String signIn = '/sign-in';
  static const String home = '/home';

  static const String incidentReport = '/incident-report';
  static const String incidentReportMaps = '/incident-report-maps';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.incidentReport,
      page: () => const IncidentReportView(),
      binding: IncidentReportBinding(),
    ),
    GetPage(
      name: Routes.incidentReportMaps,
      page: () => const IncidentMap(),
      binding: IncidentReportBinding(),
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
