import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

/// A small badge pill showing a status label with color-coded background.
/// Used in the settlements tab.
class FinancialStatusBadge extends StatelessWidget {
  const FinancialStatusBadge({
    super.key,
    required this.label,
    required this.isCompleted,
  });

  final String label;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 3.height),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.successColor.withValues(alpha: 0.1)
            : AppColors.rate.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.radius),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(11),
          fontWeight: FontWeight.w500,
          color: isCompleted ? AppColors.successColor : AppColors.brownColor,
        ),
      ),
    );
  }
}
