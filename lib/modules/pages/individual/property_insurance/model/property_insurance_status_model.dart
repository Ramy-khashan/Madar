import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';

class PropertyInsuranceStatusModel {
  final String label;
  final Color bgColor;
  final Color textColor;

  const PropertyInsuranceStatusModel({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });

  static PropertyInsuranceStatusModel statusInfo(String status, BuildContext context) {
    switch (status) {
      case 'active':
        return PropertyInsuranceStatusModel(
          label: AppStrings.activeInsuranceStatus,
          bgColor: AppColors.successColor.withValues(alpha: 0.12),
          textColor: AppColors.successColor,
        );
      case 'renewal_pending':
        return PropertyInsuranceStatusModel(
          label: AppStrings.renewalPendingStatus,
          bgColor: AppThemeColors.of(
            context,
          ).primaryBrand.withValues(alpha: 0.12),
          textColor: AppThemeColors.of(context).primaryBrand,
        );
      case 'expired':
        return PropertyInsuranceStatusModel(
          label: AppStrings.expiredInsuranceStatus,
          bgColor: AppThemeColors.of(
            context,
          ).textSecondary.withValues(alpha: 0.15),
          textColor: AppThemeColors.of(context).textSecondary,
        );
      default:
        return PropertyInsuranceStatusModel(
          label: status,
          bgColor: AppThemeColors.of(
            context,
          ).textSecondary.withValues(alpha: 0.15),
          textColor: AppThemeColors.of(context).textSecondary,
        );
    }
  }
}
