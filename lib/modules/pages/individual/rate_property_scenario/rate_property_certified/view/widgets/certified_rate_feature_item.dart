
import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class FeatureRow extends StatelessWidget {
  const FeatureRow({super.key, 
    required this.icon,
    required this.title,
    required this.desc,
    required this.colors,
  });

  final IconData icon;
  final String title;
  final String desc;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.width,
          height: 36.width,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.primaryBrand.withValues(alpha: 0.1),
          ),
          child: Icon(icon, color: colors.primaryBrand, size: 18.width),
        ),
        SizedBox(width: 12.width),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              SizedBox(height: 2.height),
              Text(
                desc,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
