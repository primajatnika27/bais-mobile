import 'package:flutter/material.dart';

enum EnvType {
  dev,
  staging,
  prod,
}

class EnvValues {
  final String titleApp;

  const EnvValues({
    this.titleApp = "BAIS DEV",
  });
}

class EnvConfig {
  final EnvType flavor;
  final MaterialColor color;
  final EnvValues values;
  final String server;
  final String webViewServer;
  final String webApiServer;

  static EnvConfig? _instance;

  EnvConfig({
    this.flavor = EnvType.staging,
    this.color = Colors.orange,
    this.values = const EnvValues(),
    this.server = '',
    this.webApiServer = '',
    this.webViewServer = '',
  }) {
    _instance = this;
  }

  static EnvConfig get instance => _instance ?? EnvConfig();
}