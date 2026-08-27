import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/user_profile_model.dart';
import 'settings_info_row.dart';

class PersonalInfoSectionWidget extends StatelessWidget {
  const PersonalInfoSectionWidget({
    super.key,
    this.onEditName,
    required this.isLoading,
    this.onEditPhone,
    this.profile,
  });

  final UserProfileModel? profile;
  final VoidCallback? onEditName;
  final VoidCallback? onEditPhone;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 16.height),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppStrings.personalInfo,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),

          SettingsInfoRow(
            label: AppStrings.settingsName,
            value: isLoading ? '......' : profile?.name ?? 'User Name',
            onEdit: onEditName,
            colors: colors,
          ),
          SettingsInfoRow(
            label: AppStrings.phoneNumber,
            value: isLoading ? '......' : profile?.phone ?? 'User Phone',
            onEdit: onEditPhone,
            colors: colors,
          ),
        ],
      ),
    );
  }
}

