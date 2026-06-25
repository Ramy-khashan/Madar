import 'package:flutter/material.dart';

import '../../../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../../../core/components/app_button.dart';
import '../../../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/components/image_item.dart';

class RoleCardWidget extends StatelessWidget {
  const RoleCardWidget({
    super.key,
    required this.roleKey,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.icon,
    required this.selectedRole,
    required this.onSelect,
    required this.onConfirm,
  });

  final String roleKey;
  final String title;
  final String description;
  final String buttonLabel;
  final String icon;
  final String selectedRole;
  final VoidCallback onSelect;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final isSelected = selectedRole == roleKey;

    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 13.width, vertical: 16.height),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(20.radius),
          border: Border.all(
            color: isSelected ? colors.primaryBrand : colors.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18.width,
                  backgroundColor: colors.primaryBrand.withValues(alpha: 0.08),
                  child: ImageItem(icon, color: colors.primaryBrand),
                ),
                SizedBox(width: 8.width),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                      SizedBox(height: 8.height),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.height),
            AppButton(
              text: buttonLabel,
              onTap: onConfirm,
              height: 48,
              textSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
