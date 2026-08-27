import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AddPropertySectionLabel extends StatelessWidget {
  const AddPropertySectionLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Text(
      label,
      style: TextStyle(
        fontSize: context.responsiveFontScale(16),
        fontWeight: FontWeight.w700,
        color: tc.textPrimary,
      ),
    );
  }
}
