import 'package:flutter/material.dart';

import '../../../config/router/app_router_keys.dart';
import '../constants/app_enums.dart';
import '../constants/storage_keys.dart';
import 'preference_utils.dart';
import 'router_handler.dart';

enum GuestAuthPrompt { sheet, toast }

class GuestMode {
  GuestMode._();

  static bool get isGuest => PreferenceUtils().getBool(StorageKeys.isGuest);

  static Future<void> exitToChooseRole(BuildContext context) async {
    await PreferenceUtils().setBool(StorageKeys.isGuest, false);
    if (!context.mounted) return;
    RouterHandler.navigate(
      context,
      AppRouterKeys.chooseAccount,
      routerType: RouterType.goName,
    );
  }

  static bool requireAuth(
    BuildContext context, {
    GuestAuthPrompt? prompt,
    String? title,
    String? subtitle,
  }) {
    if (!isGuest) return true;
    exitToChooseRole(context);
    return false;
  }
}
