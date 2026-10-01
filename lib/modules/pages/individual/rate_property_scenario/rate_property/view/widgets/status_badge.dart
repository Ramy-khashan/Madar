import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, required this.colors});

  final String status;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case 'ready':
        color = AppColors.successColor;
        label = AppStrings.ratePropertyReadyBadge;
        break;
      case 'underReview':
        color = Colors.orange;
        label = AppStrings.underReviewStatus;
        break;
      case 'newRequest':
        color = AppColors.secondBrand;
        label = AppStrings.newStatusBadge;
        break;
      default:
        color = colors.textSecondary;
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 3.height),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(12),
          color: color,
          fontFamily: AppConstant.appFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
