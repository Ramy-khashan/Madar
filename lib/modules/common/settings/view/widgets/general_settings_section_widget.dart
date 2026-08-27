import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import 'settings_action_row.dart';
import 'settings_toggle_row.dart';

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
