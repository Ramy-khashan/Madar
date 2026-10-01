import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class RevenueSection extends StatelessWidget {
  const RevenueSection({
    super.key,
    required this.title,
    required this.trailing,
    required this.colors,
    required this.child,
  });

  final String title;
  final String trailing;
  final AppThemeColors colors;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
              ),
              Text(
                trailing,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          child,
        ],
      ),
    );
  }
}
