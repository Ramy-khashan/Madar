import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../../core/components/image_item.dart';

class GeneralSettingsSectionWidget extends StatelessWidget {
  const GeneralSettingsSectionWidget({
    super.key,
    required this.selectedLanguage,
    required this.notificationsEnabled,
    required this.onNotificationsToggled,
    required this.darkModeEnabled,
    required this.onDarkModeToggled,
    required this.onLanguageTap,
    required this.onTermsTap,
    required this.onHelpTap,
  });

  final String selectedLanguage;
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final VoidCallback onNotificationsToggled;
  final VoidCallback onDarkModeToggled;
  final VoidCallback onLanguageTap;
  final VoidCallback onTermsTap;
  final VoidCallback onHelpTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 8.height),
      padding: EdgeInsets.all(16.width),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.generalSettings,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),

          SettingsActionRow(
            icon: Icons.language_outlined,
            label: selectedLanguage.trans,
            colors: colors,
            onTap: onLanguageTap,
          ),
          SettingsToggleRow(
            icon: Icons.dark_mode,
            label: AppStrings.darkMode,
            value: darkModeEnabled,
            colors: colors,
            onToggle: onDarkModeToggled,
          ),
          SettingsToggleRow(
            icon: Icons.notifications_outlined,
            label: AppStrings.notifications,
            value: notificationsEnabled,
            colors: colors,
            onToggle: onNotificationsToggled,
          ),
          SettingsActionRow(
            icon: Icons.shield_outlined,
            label: AppStrings.termsAndConditions,
            colors: colors,
            onTap: onTermsTap,
          ),
          SettingsActionRow(
            icon: Icons.help_outline,
            label: AppStrings.helpAndSupport,
            colors: colors,
            onTap: onHelpTap,
          ),

          // SettingsActionRow(
          //   icon: Icons.switch_account_outlined,
          //   label: ,
          //   colors: colors,
          //   onTap: onSwitchAccountTap,
          // ),
        ],
      ),
    );
  }
}

class SettingsActionRow extends StatelessWidget {
  const SettingsActionRow({
    super.key,
    this.icon,
    this.image,
    this.trailing,
    required this.label,
    required this.colors,
    required this.onTap,
    this.isReadTag = false,
  });

  final IconData? icon;
  final String? image;
  final String label;
  final Widget? trailing;
  final AppThemeColors colors;
  final VoidCallback onTap;
  final bool isReadTag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.radius),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.radius),
          color: colors.hoverColor.withValues(alpha: 0.1),
          border: Border.all(color: colors.borderColor),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 8.height,
          vertical: 14.height,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.width),
              decoration: BoxDecoration(
                color: isReadTag
                    ? AppColors.errorColor.withValues(alpha: 0.08)
                    : colors.primaryBrand.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: image != null
                  ? ImageItem(image!, width: 20.width, height: 20.width)
                  : Icon(
                      icon,
                      size: 20.width,
                      color: isReadTag
                          ? AppColors.errorColor
                          : colors.primaryBrand,
                    ),
            ),
            SizedBox(width: 12.width),

            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w500,
                  color: isReadTag
                      ? AppColors.errorColor
                      : colors.textFieldTitle,
                ),
              ),
            ),
            trailing ?? SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.onToggle,
  });

  final IconData icon;
  final String label;
  final bool value;
  final AppThemeColors colors;
  final VoidCallback onToggle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.radius),
        color: colors.hoverColor.withValues(alpha: 0.1),
        border: Border.all(color: colors.borderColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.height, vertical: 14.height),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.width),
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20.width, color: colors.primaryBrand),
          ),
          SizedBox(width: 12.width),

          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w500,
              color: colors.textFieldTitle,
            ),
          ),

          const Spacer(),
          GestureDetector(
            onTap: onToggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: ResponsiveUtils.types(
                context,
                mobilePortrait: 52.width,
                mobileLandscape: 80.width,
                tabletPortrait: 120.width,
                tabletLandscape: 70.width,
              ),
              height: 30.height,
              padding: EdgeInsets.all(3.width),
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderColor),
                color: value
                    ? AppColors.backgroundLight
                    : colors.borderColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.radius),
              ),
              child: Row(
                children: [
                  if (value)
                    Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.on,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(8),
                            fontWeight: FontWeight.w600,
                            fontFamily: AppConstant.appHeaderFont,
                            color: AppColors.secondBrand,
                          ),
                        ),
                      ),
                    ),
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    alignment: value
                        ? AlignmentDirectional.centerEnd
                        : AlignmentDirectional.centerStart,
                    child: Container(
                      width: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 20.width,
                        mobileLandscape: 30.width,
                        tabletPortrait: 50.width,
                        tabletLandscape: 30.width,
                      ),
                      height: 30.width,
                      decoration: const BoxDecoration(
                        color: AppColors.secondBrand,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  if (!value)
                    Expanded(
                      child: Center(
                        child: Text(
                          AppStrings.off,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(8),
                            fontWeight: FontWeight.w600,
                            fontFamily: AppConstant.appHeaderFont,
                            color: AppColors.secondBrand,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
