 

import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/functions/responsive.dart';

class IconInfoRow extends StatelessWidget {
  const IconInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Row(
      children: [
        Icon(icon, size: 20.width, color: colors.textSecondary),
        SizedBox(width: 8.width),
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
            ),
          ),
        const Spacer(),
        if (value.isNotEmpty)
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              color: valueColor ?? colors.textFieldTitle,
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: valueColor != null
                  ? FontWeight.w600
                  : FontWeight.w500,
            ),
          ),
      ],
    );
  }
}
