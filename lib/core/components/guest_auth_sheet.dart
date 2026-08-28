import 'package:flutter/material.dart';

import '../utils/functions/guest_mode.dart';

/// Sends the guest to select-role and clears the navigation stack.
Future<void> showGuestAuthSheet(
  BuildContext context, {
  String? title,
  String? subtitle,
}) {
  return GuestMode.exitToChooseRole(context);
}
