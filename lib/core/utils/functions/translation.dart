import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> initLocalization() async {
  await EasyLocalization.ensureInitialized();
}

EasyLocalization localization(Widget app) => EasyLocalization(
  supportedLocales: const [Locale('en'), Locale('ar')],
  path: 'assets/translate',
  fallbackLocale: const Locale('ar'),
  saveLocale: true,
  startLocale: const Locale('ar'),
  child: app,
);

List<LocalizationsDelegate<dynamic>> localizationDelegates(
  BuildContext context,
) => context.localizationDelegates;

List<Locale> supportedLocales(BuildContext context) => context.supportedLocales;

Locale locale(BuildContext context) => context.locale;

Future<void> changeLanguage(BuildContext context, String lang) async {
  await context.setLocale(Locale(lang));
}

extension Translation on String {
  String get trans => this.tr();

  String transNamed(Map<String, String> args) => tr(this, namedArgs: args);

  bool get hasTrans {
    try {
      return trExists(this);
    } catch (_) {
      return false;
    }
  }

  String get transIfExists => hasTrans ? trans : this;
}



