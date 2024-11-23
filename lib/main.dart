import 'package:bais_mobile/app.dart';
import 'package:bais_mobile/config/env.dart';
import 'package:bais_mobile/config/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> mainCommon(EnvConfig env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    AppWidget(
      initialRoute: await AppPages.initialRoute,
    ),
  );
}
