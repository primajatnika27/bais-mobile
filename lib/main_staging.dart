import 'package:bais_mobile/config/env.dart';
import 'package:bais_mobile/main.dart';
import 'package:flutter/material.dart';

void main() async {
  await mainCommon(
    EnvConfig(
      color: Colors.yellow,
      server: 'https://577c-66-96-225-188.ngrok-free.app',
      flavor: EnvType.dev,
      values: const EnvValues(titleApp: "STAGING MODE"),
      webApiServer: '',
    ),
  );
}