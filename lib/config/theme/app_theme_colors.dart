import 'package:flutter/material.dart';

import '../../core/utils/constants/app_colors.dart';

class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.surface,
    required this.cardBackground,
    required this.borderColor,
    required this.hoverColor,
    required this.activeColor,
    required this.textPrimary,
    required this.textSecondary,
    required this.textFieldTitle,
    required this.textFieldHint,
    required this.textFieldBorder,
    required this.textFieldFill,
    required this.primaryBrand,
    required this.onPrimary,
  });

  final Color backgroundPrimary;

  final Color backgroundSecondary;

  final Color surface;

  final Color cardBackground;

  final Color borderColor;

  final Color hoverColor;

  final Color activeColor;

  final Color textPrimary;

  final Color textSecondary;

  final Color textFieldTitle;

  final Color textFieldHint;

  final Color textFieldBorder;

  final Color textFieldFill;

  final Color primaryBrand;

  final Color onPrimary;

  static AppThemeColors of(BuildContext context) =>
      Theme.of(context).extension<AppThemeColors>()!;

  static const light = AppThemeColors(
    backgroundPrimary: AppColors.white,
    backgroundSecondary: AppColors.white,
    surface: AppColors.white,
    cardBackground: AppColors.white,
    borderColor: AppColors.grey300,
    hoverColor: AppColors.grey200,
    activeColor: AppColors.grey300,
    textPrimary: AppColors.primary300,
    textSecondary: AppColors.secondaryTextBase,
    textFieldTitle: AppColors.darkSurface,
    textFieldHint: AppColors.grey600,
    textFieldBorder: AppColors.textFieldBorder,
    textFieldFill: AppColors.white,
    primaryBrand: AppColors.primary300,
    onPrimary: AppColors.white,
  );

  static const dark = AppThemeColors(
    backgroundPrimary: AppColors.darkSurface,
    backgroundSecondary: AppColors.grey900,
    surface: Color.fromRGBO(112, 112, 112, 1),
    cardBackground: Color.fromARGB(255, 39, 48, 59),
    borderColor: AppColors.grey800,
    hoverColor: AppColors.grey700,
    activeColor: AppColors.grey600,
    textPrimary: AppColors.white,
    textSecondary: AppColors.grey600,
    textFieldTitle: AppColors.white,
    textFieldHint: AppColors.grey600,
    textFieldBorder: AppColors.grey700,
    textFieldFill: Color.fromARGB(255, 39, 48, 59),
    primaryBrand: AppColors.secondBrand,
    onPrimary: AppColors.white,
  );

  @override
  AppThemeColors copyWith({
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? surface,
    Color? cardBackground,
    Color? borderColor,
    Color? hoverColor,
    Color? activeColor,
    Color? textPrimary,
    Color? textSecondary,
    Color? textFieldTitle,
    Color? textFieldHint,
    Color? textFieldBorder,
    Color? textFieldFill,
    Color? primaryBrand,
    Color? onPrimary,
  }) {
    return AppThemeColors(
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      surface: surface ?? this.surface,
      cardBackground: cardBackground ?? this.cardBackground,
      borderColor: borderColor ?? this.borderColor,
      hoverColor: hoverColor ?? this.hoverColor,
      activeColor: activeColor ?? this.activeColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textFieldTitle: textFieldTitle ?? this.textFieldTitle,
      textFieldHint: textFieldHint ?? this.textFieldHint,
      textFieldBorder: textFieldBorder ?? this.textFieldBorder,
      textFieldFill: textFieldFill ?? this.textFieldFill,
      primaryBrand: primaryBrand ?? this.primaryBrand,
      onPrimary: onPrimary ?? this.onPrimary,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      backgroundPrimary: Color.lerp(
        backgroundPrimary,
        other.backgroundPrimary,
        t,
      )!,
      backgroundSecondary: Color.lerp(
        backgroundSecondary,
        other.backgroundSecondary,
        t,
      )!,
      surface: Color.lerp(surface, other.surface, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textFieldTitle: Color.lerp(textFieldTitle, other.textFieldTitle, t)!,
      textFieldHint: Color.lerp(textFieldHint, other.textFieldHint, t)!,
      textFieldBorder: Color.lerp(textFieldBorder, other.textFieldBorder, t)!,
      textFieldFill: Color.lerp(textFieldFill, other.textFieldFill, t)!,
      primaryBrand: Color.lerp(primaryBrand, other.primaryBrand, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
    );
  }
}
