import 'package:flutter/material.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';

class PublicationStatusTag extends StatelessWidget {
  const PublicationStatusTag({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final value = status.trim().toUpperCase();
    final isApproved = value == 'APPROVED';

    final color = isApproved ? AppColors.successColor : AppColors.orangeColor;
    final label = isApproved
        ? AppStrings.publishedStatus
        : AppStrings.notPublishedStatus;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: isApproved
            ? color.withValues(alpha: 0.12)
            : AppColors.rate.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(12),
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
