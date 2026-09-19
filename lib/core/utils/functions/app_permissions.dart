import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

import 'notification_service.dart';

class AppPermissions {
  AppPermissions._();

  static Future<void>? _notificationsInFlight;
  static Future<void>? _locationInFlight;

  static Future<void> requestNotifications() {
    return _notificationsInFlight ??= _requestNotifications();
  }

  static Future<void> requestLocation() {
    return _locationInFlight ??= _requestLocation();
  }

  static Future<void> _requestLocation() async {
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
    } catch (_) {}
  }

  static Future<void> _requestNotifications() async {
    try {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      await NotificationService.instance.requestPermissions();
    } catch (_) {}
  }
}
