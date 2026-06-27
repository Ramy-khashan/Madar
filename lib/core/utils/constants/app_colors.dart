import 'package:flutter/material.dart';

/// Raw design-system palette tokens.
/// Use [AppThemeColors.of(context)] in widgets — never reference these directly in UI.
class AppColors {
  AppColors._();
  static const errorColor = Colors.red;
  static const lightSuccessColor = Color.fromARGB(255, 1, 162, 109);
  static const successColor = Color(0xFF00875A);
  static const darkGreenColor = Color.fromARGB(255, 2, 78, 52);
  static const secondBrand = Color.fromARGB(255, 52, 103, 162);
  static const blueColor = Color(0xFFBEDBFF);
  static const rate = Colors.amber;
  static const backgroundLight = Color(0xFFEFF6FF);
  static const brownColor = Color(0xFF7B3306);
  static const orangeColor = Color.fromARGB(255, 198, 84, 14);
  // ── Neutral (Grey Scale) ────────────────────────────────────────────────
  static const grey50 = Color(0xFFFAFAFA);
  static const grey100 = Color(0xFFEFEFEF);
  static const grey200 = Color(0xFFE8E8E8);
  static const grey300 = Color(0xFFDDDDDD);
  static const grey400 = Color(0xFFD6D6D6);
  static const grey500 = Color(0xFFCCCCCC);
  static const grey600 = Color(0xFFBABABA);
  static const grey700 = Color(0xFF919191);
  static const grey800 = Color(0xFF707070);
  static const grey900 = Color(0xFF565656);

  // ── Primary (Blue Scale) ───────────────────────────────────────────────
  static const primary900 = Color(0xFF060C13);
  static const primary800 = Color(0xFF09111B);
  static const primary700 = Color(0xFF0C1827);
  static const primary600 = Color(0xFF102032);
  static const primary500 = Color(0xFF14273D);
  static const primary400 = Color(0xFF182E49);
  static const primary300 = Color(0xFF1B3553); // main brand blue

  // ── Functional ─────────────────────────────────────────────────────────
  static const white = Color(0xFFFFFFFF);
  static const transparent = Color(0x00000000);

  // Kept for backward-compat during migration; prefer semantic tokens.
  static const secondaryTextBase = Color(0xFF566981);
  static const darkSurface = Color(0xFF1E252D);
  static const textFieldBorder = Color(0xFFA3A3A3);
}
