import 'package:flutter/material.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/user_profile_model.dart';

class PersonalInfoSectionWidget extends StatelessWidget {
  const PersonalInfoSectionWidget({
    super.key,
    required this.onEditName,
    required this.isLoading,
    required this.onEditPhone,
    this.profile,
  });

  final UserProfileModel? profile;
  final VoidCallback onEditName;
  final VoidCallback onEditPhone;
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
            value: isLoading ? "......" : profile?.name ?? 'User Name',
            onEdit: onEditName,
            colors: colors,
          ),
          SettingsInfoRow(
            label: AppStrings.phoneNumber,
            value: isLoading ? "......" : profile?.phone ?? 'User Phone',
            onEdit: onEditPhone,
            colors: colors,
          ),
        ],
      ),
    );
  }
}

class SettingsInfoRow extends StatelessWidget {
  const SettingsInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.onEdit,
    required this.colors,
  });

  final String label;
  final String value;
  final VoidCallback onEdit;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.height),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.radius),
          border: Border.all(color: colors.borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: colors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 2.height),
                  Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w600,
                      color: colors.textFieldTitle,
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: onEdit,
              child: ImageItem(AppImages.editIcon, color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
