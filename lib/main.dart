import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
 
import 'core/utils/functions/fcm_token_service.dart';
import 'core/utils/functions/responsive.dart';
import 'core/utils/functions/service_locator.dart';
import 'core/utils/functions/translation.dart';
import 'firebase_options.dart';
import 'madar_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    initScreenUtils(),
    initLocalization(),
    intiService(),
      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ]),
  ]);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (_) {}

  runApp(localization(const MadarApp()));
}
 