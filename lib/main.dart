import 'package:bais_mobile/app.dart';
import 'package:bais_mobile/config/env.dart';
import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/core/services/shared_preference_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> mainCommon(EnvConfig env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize and inject SharedPreferencesService
  final sharedPreferencesService = SharedPreferenceService();
  await sharedPreferencesService.init();
  Get.put<SharedPreferenceService>(sharedPreferencesService);

  runApp(
    AppWidget(
      initialRoute: await AppPages.initialRoute,
    ),
  );
}
