
import 'package:bais_mobile/config/routes.dart';
import 'package:bais_mobile/features/auth/signIn/bindings/signin_binding.dart';
import 'package:bais_mobile/features/auth/signIn/views/signin_view.dart';
import 'package:bais_mobile/features/home/bindings/home_binding.dart';
import 'package:bais_mobile/features/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  final String initialRoute;
  const AppWidget({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SII Mobile",
      theme: ThemeData(
        fontFamily: 'Inter',
        useMaterial3: false,
      ),
      getPages: AppPages.routes,
      initialRoute: Routes.signIn,
      home: const SignInView(),
      initialBinding: SignInBinding(),
      locale: const Locale('id', 'ID'),
    );
  }
}
