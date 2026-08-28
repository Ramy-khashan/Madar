import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

/// Requests the runtime permissions the app uses on launch.
class AppPermissions {
  AppPermissions._();

  static Future<void> requestStartupPermissions() async {
    await Future.wait([
      _requestLocation(),
      _requestNotifications(),
    ]);
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
    } catch (_) {}
  }
}
