import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../config/theme/app_theme_colors.dart';
import 'components/app_button.dart';
import 'utils/constants/app_constant.dart';
import 'utils/constants/app_strings.dart';
import 'utils/functions/print_state.dart';
import 'utils/functions/responsive.dart';

/// Firebase kill switch.
///
/// Console: Remote Config → publish
///   is_working (Boolean) default true
///   maintenance_title (String) optional
///   maintenance_description (String) optional
///
/// To remove later:
/// 1. Delete this file
/// 2. Remove [AppKillSwitchGate] from [MadarApp] builder
/// 3. `fvm flutter pub remove firebase_remote_config`
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

  StreamSubscription<RemoteConfigUpdate>? _sub; // ignore: cancel_subscriptions
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
      // App-lifetime listener; cancelled only if the process dies.
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

class AppKillSwitchGate extends StatefulWidget {
  const AppKillSwitchGate({super.key, required this.child});

  final Widget child;

  @override
  State<AppKillSwitchGate> createState() => _AppKillSwitchGateState();
}

class _AppKillSwitchGateState extends State<AppKillSwitchGate> {
  @override
  void initState() {
    super.initState();
    AppKillSwitch.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppKillSwitch.instance,
      builder: (context, _) {
        final kill = AppKillSwitch.instance;
        return Stack(
          alignment: Alignment.topLeft,
          children: [
            widget.child,
            if (!kill.isWorking) _MaintenanceOverlay(kill: kill),
          ],
        );
      },
    );
  }
}

class _MaintenanceOverlay extends StatelessWidget {
  const _MaintenanceOverlay({required this.kill});

  final AppKillSwitch kill;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final title = kill.title.isEmpty ? AppStrings.appPausedTitle : kill.title;
    final description = kill.description.isEmpty
        ? AppStrings.appPausedDescription
        : kill.description;

    return Positioned.fill(
      child: PopScope(
        canPop: false,
        child: Material(
          color: colors.backgroundPrimary,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 72.width,
                    height: 72.width,
                    decoration: BoxDecoration(
                      color: colors.primaryBrand.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.pause_circle_outline_rounded,
                      size: 36.width,
                      color: colors.primaryBrand,
                    ),
                  ),
                  SizedBox(height: 24.height),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(20),
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstant.appHeaderFont,
                      color: colors.textFieldTitle,
                    ),
                  ),
                  SizedBox(height: 12.height),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      height: 1.5,
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 32.height),
                  AppButton(
                    childText: AppStrings.appPausedRefresh,
                    childIcon: Icons.refresh_rounded,
                    isLoading: kill.isRefreshing,
                    onTap: kill.refresh,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
