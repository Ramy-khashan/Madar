import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import 'utils/functions/print_state.dart';
import 'maintenance_overlay.dart';

class AppKillSwitch extends ChangeNotifier {
  AppKillSwitch._();
  static final AppKillSwitch instance = AppKillSwitch._();

  static const String isWorkingKey = 'is_working';
  static const String titleKey = 'maintenance_title';
  static const String descriptionKey = 'maintenance_description';

  bool isWorking = true;
  bool isRefreshing = false;
  String title = '';
  String description = '';

  StreamSubscription<RemoteConfigUpdate>? _sub;
  bool _started = false;

  Future<void> init() async {
    if (_started) return;
    try {
      if (Firebase.apps.isEmpty) return;
      _started = true;
      final rc = FirebaseRemoteConfig.instance;
      await rc.setDefaults(const {
        isWorkingKey: true,
        titleKey: '',
        descriptionKey: '',
      });
      await rc.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await rc.fetchAndActivate();
      _apply(rc);

      _sub ??= rc.onConfigUpdated.listen((_) async {
        await rc.activate();
        _apply(rc);
      });
    } catch (e) {
      printState('AppKillSwitch.init: $e');
    }
  }

  void _apply(FirebaseRemoteConfig rc) {
    final nextWorking = rc.getBool(isWorkingKey);
    final nextTitle = rc.getString(titleKey).trim();
    final nextDescription = rc.getString(descriptionKey).trim();
    if (nextWorking == isWorking &&
        nextTitle == title &&
        nextDescription == description) {
      return;
    }
    isWorking = nextWorking;
    title = nextTitle;
    description = nextDescription;
    notifyListeners();
  }

  Future<void> refresh() async {
    if (isRefreshing) return;
    isRefreshing = true;
    notifyListeners();
    try {
      if (Firebase.apps.isEmpty) return;
      final rc = FirebaseRemoteConfig.instance;
      await rc.fetchAndActivate();
      _apply(rc);
    } catch (e) {
      printState('AppKillSwitch.refresh: $e');
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }
}

class AppKillSwitchGate extends StatelessWidget {
  const AppKillSwitchGate({super.key, required this.child});

  final Widget child;

  static bool _initCalled = false;

  @override
  Widget build(BuildContext context) {
    if (!_initCalled) {
      _initCalled = true;
      AppKillSwitch.instance.init();
    }
    return ListenableBuilder(
      listenable: AppKillSwitch.instance,
      builder: (context, _) {
        final kill = AppKillSwitch.instance;
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            child,
            if (!kill.isWorking) MaintenanceOverlay(kill: kill),
          ],
        );
      },
    );
  }
}
