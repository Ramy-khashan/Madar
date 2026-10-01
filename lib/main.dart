import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'core/repository/error_tracking/crashlytics_collector.dart';
import 'core/utils/functions/fcm_token_service.dart';
import 'core/utils/functions/print_state.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/translation.dart';
import 'firebase_options.dart';
import 'madar_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initScreenUtils(), initLocalization(), intiService()]);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    CrashlyticsCollector().setup();
  } catch (error, stack) {
    printState('Firebase init failed: $error\n$stack');
  }

  runApp(localization(const MadarApp()));
}
