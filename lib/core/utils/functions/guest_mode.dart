import 'package:flutter/material.dart';

import '../../components/guest_auth_sheet.dart';
import '../constants/app_strings.dart';
import '../constants/storage_keys.dart';
import 'common_fun.dart';
import 'preference_utils.dart';

enum GuestAuthPrompt { sheet, toast }

class GuestMode {
  GuestMode._();

  static bool get isGuest => PreferenceUtils().getBool(StorageKeys.isGuest);

  /// Returns `true` when the user may continue. Guests are prompted and
  /// the method returns `false`.
  static bool requireAuth(
    BuildContext context, {
    GuestAuthPrompt prompt = GuestAuthPrompt.sheet,
    String? title,
    String? subtitle,
  }) {
    if (!isGuest) return true;
    switch (prompt) {
      case GuestAuthPrompt.toast:
        AppToast(AppStrings.guestLoginRequiredToast);
      case GuestAuthPrompt.sheet:
        showGuestAuthSheet(context, title: title, subtitle: subtitle);
    }
    return false;
  }
}
