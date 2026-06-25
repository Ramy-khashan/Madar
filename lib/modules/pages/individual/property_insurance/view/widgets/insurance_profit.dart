import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class InsuranceProfit extends StatelessWidget {
  const InsuranceProfit({
    super.key,
    required this.features,
    required this.title,
  });
  final List<String> features;
  final String title;
  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return OutlinedSection(
      title: title,
      titleFontSize: 18,
      child: Column(
        children: [
          ...features.map(
            (e) => ListTile(
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
              dense: true,
              leading: CircleAvatar(
                radius: 13.width,
                backgroundColor: AppThemeColors.of(
                  context,
                ).primaryBrand.withValues(alpha: 0.1),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  size: 18.width,
                  color: AppThemeColors.of(context).primaryBrand,
                ),
              ),
              title: Text(
                e,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: colors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
