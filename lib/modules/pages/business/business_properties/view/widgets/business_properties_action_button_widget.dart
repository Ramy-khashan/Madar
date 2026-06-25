import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class BusinessPropertiesActionButton extends StatelessWidget {
  const BusinessPropertiesActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isOutline,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isOutline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final bgColor = isOutline ? colors.cardBackground : AppColors.successColor;
    final fgColor = isOutline ? AppColors.errorColor : AppColors.white;
    final borderColor = isOutline ? AppColors.errorColor : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32.radius),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.width, color: fgColor),
            SizedBox(width: 6.width),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: fgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
