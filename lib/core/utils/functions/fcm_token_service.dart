import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../firebase_options.dart';
import '../../repository/apis/auth_apis.dart';
import '../constants/app_enums.dart';
import 'handle_multi_callback.dart';
import 'notification_service.dart';
import 'print_state.dart';
import 'service_locator.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    printState('FCM background init error: $e');
  }
}

class FcmTokenService {
  FcmTokenService._();
  static final FcmTokenService instance = FcmTokenService._();

  bool _initialized = false;
  void Function(Map<String, dynamic> data)? onOpened;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }

      await NotificationService.instance.init();
      NotificationService.instance.onTap = (payload) {
        onOpened?.call(_payloadMap(payload));
      };

      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: Platform.isIOS,
            badge: true,
            sound: Platform.isIOS,
          );

      FirebaseMessaging.instance.onTokenRefresh.listen(syncToken);
      await syncToken();

      FirebaseMessaging.onMessage.listen(_onForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onOpenedMessage);
      final initial = await FirebaseMessaging.instance.getInitialMessage();
      if (initial != null) {
        _onOpenedMessage(initial);
      }
    } catch (e) {
      printState('FcmTokenService.init error: $e');
    }
  }

  Future<void> syncToken([String? token]) async {
    try {
      final accessToken = await sl.get<HandleMultiCallLocal>().getLocalData(
        keyType: LocalEnumKey.accessToken,
      );
      if (accessToken == null || accessToken.isEmpty) return;
      final fcmToken = token ?? await FirebaseMessaging.instance.getToken();
      if (fcmToken == null || fcmToken.isEmpty) return;
      await AuthApis.saveFcmToken(fcmToken: fcmToken);
    } catch (e) {
      printState('FcmTokenService.syncToken error: $e');
    }
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    final title =
        notification?.title ?? message.data['title']?.toString() ?? '';
    final body = notification?.body ?? message.data['body']?.toString() ?? '';
    if (title.isEmpty && body.isEmpty) return;
    await NotificationService.instance.show(
      id: message.hashCode,
      title: title.isEmpty ? 'Madar' : title,
      body: body,
      payload: jsonEncode(message.data),
    );
  }

  void _onOpenedMessage(RemoteMessage message) {
    onOpened?.call(Map<String, dynamic>.from(message.data));
  }

  Map<String, dynamic> _payloadMap(String? payload) {
    if (payload == null || payload.isEmpty) return const {};
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
    } catch (_) {}
    return const {};
  }
}
