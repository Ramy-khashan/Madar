
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyInsuranceRequestInfo extends StatelessWidget {
  const PropertyInsuranceRequestInfo({super.key, 
    required this.label,
    required this.value,
    required this.colors,
    required this.context,
  });

  final String label;
  final String value;
  final AppThemeColors colors;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            color: colors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w600,
            color: colors.textFieldTitle,
          ),
        ),
      ],
    );
  }
}
