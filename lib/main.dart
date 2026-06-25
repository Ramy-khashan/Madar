import 'package:flutter/material.dart';

import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/translation.dart';
import 'madar_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initScreenUtils(), initLocalization(), intiService()]);

  runApp(localization(const MadarApp()));
}
