import 'package:flutter/material.dart';

import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_constant.dart';
import 'app_theme_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    const c = AppThemeColors.light;
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConstant.appFont,
      brightness: Brightness.light,
      extensions: const [c],
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary300,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary600,
        onPrimaryContainer: AppColors.white,
        secondary: AppColors.secondaryTextBase,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.white,
        onSecondaryContainer: AppColors.darkSurface,
        surface: c.surface,
        onSurface: c.textPrimary,
        error: const Color(0xFFB00020),
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: c.backgroundPrimary,
      cardTheme: CardThemeData(
        color: c.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: DividerThemeData(color: c.borderColor),
      textTheme: _buildTextTheme(c.textPrimary, c.textSecondary),
      inputDecorationTheme: _buildInputDecoration(c),
      elevatedButtonTheme: _buildElevatedButton(c),
    );
  }

  static ThemeData dark() {
    const c = AppThemeColors.dark;
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppConstant.appFont,
      brightness: Brightness.dark,
      extensions: const [c],
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.secondBrand,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary700,
        onPrimaryContainer: AppColors.white,
        secondary: AppColors.grey600,
        onSecondary: AppColors.darkSurface,
        secondaryContainer: AppColors.grey800,
        onSecondaryContainer: AppColors.white,
        surface:AppColors.darkSurface,
        onSurface: c.textPrimary,
        error: const Color(0xFFCF6679),
        onError: AppColors.darkSurface,
      ),
      scaffoldBackgroundColor: c.backgroundPrimary,
      cardTheme: CardThemeData(
        color: const Color.fromARGB(255, 39, 48, 59),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      dividerTheme: DividerThemeData(color: c.borderColor),
      textTheme: _buildTextTheme(c.textPrimary, c.textSecondary),
      inputDecorationTheme: _buildInputDecoration(c),
      elevatedButtonTheme: _buildElevatedButton(c),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(color: primary),
      displayMedium: TextStyle(color: primary),
      displaySmall: TextStyle(color: primary),
      headlineLarge: TextStyle(color: primary),
      headlineMedium: TextStyle(color: primary),
      headlineSmall: TextStyle(color: primary),
      titleLarge: TextStyle(color: primary, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: primary, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: primary, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: primary),
      bodyMedium: TextStyle(color: primary),
      bodySmall: TextStyle(color: secondary),
      labelLarge: TextStyle(color: primary, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(color: secondary),
      labelSmall: TextStyle(color: secondary),
    );
  }

  static InputDecorationTheme _buildInputDecoration(AppThemeColors c) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: BorderSide(color: c.textFieldBorder),
    );
    return InputDecorationTheme(
      filled: true,
      fillColor: c.textFieldFill,
      hintStyle: TextStyle(color: c.textFieldHint),
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(color: c.primaryBrand, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: const BorderSide(color: Color(0xFFB00020)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButton(AppThemeColors c) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: c.primaryBrand,
        foregroundColor: c.onPrimary,
        shadowColor: AppColors.transparent,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
  }
}
