import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
 
class PropertyDetailsSectionHeaderWidget extends StatelessWidget {
  const PropertyDetailsSectionHeaderWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.height),
        child: Text(
          title,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.bold,
            color: tc.textPrimary,
          ),
        ),
      ),
    );
  }
}
