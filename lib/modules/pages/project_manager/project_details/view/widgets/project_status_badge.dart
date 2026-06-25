
import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ProjectStatusBadge extends StatelessWidget {
  const ProjectStatusBadge({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == 'completed';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.successColor.withValues(alpha: 0.15)
            : const Color(0xFF3B82F6).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isCompleted ? AppStrings.completed : AppStrings.ongoing,
        style: TextStyle(
          fontSize: context.responsiveFontScale(11),
          fontWeight: FontWeight.w700,
          color: isCompleted ? AppColors.successColor : const Color(0xFF3B82F6),
        ),
      ),
    );
  }
}

