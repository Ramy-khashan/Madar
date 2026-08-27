import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/components/image_item.dart';

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
    return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.height),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.radius),
        child: Container(
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
                    ? ImageItem(image!, width: 20.width, height: 20.width,
                        color: isReadTag
                            ? AppColors.errorColor
                            : colors.primaryBrand,
                      )
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
              trailing ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
