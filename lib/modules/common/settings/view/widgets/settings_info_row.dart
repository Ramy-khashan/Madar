import 'package:flutter/material.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class SettingsInfoRow extends StatelessWidget {
  const SettingsInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.onEdit,
    required this.colors,
  });

  final String label;
  final String value;
  final VoidCallback? onEdit;
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

            if (onEdit != null)
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
