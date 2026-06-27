import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyStatusCard extends StatelessWidget {
  const PropertyStatusCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final String value;
  final String label;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.height, horizontal: 8.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: colors.primaryBrand, size: 24.width),
          SizedBox(height: 4.height),
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              color: colors.textFieldTitle,
              fontFamily: AppConstant.appHeaderFont,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(11),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ],
      ),
    );
  }
}
