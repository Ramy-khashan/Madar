import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../model/project_model.dart';
import 'project_status_badge.dart';

class ProjectPhaseRow extends StatelessWidget {
  const ProjectPhaseRow({super.key, required this.phase, required this.tc});
  final PhaseModel phase;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    final isCompleted = phase.status == 'completed';
    return GestureDetector(
      onTap: () => RouterHandler.navigate(
        context,
        AppRouterKeys.phaseDetails,
        extra: phase,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        decoration: BoxDecoration(
          color: tc.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: tc.borderColor),
        ),
        child: Row(
          children: [
            Icon(
              isCompleted
                  ? Icons.check_circle_rounded
                  : Icons.check_circle_outline_rounded,
              color: isCompleted ? AppColors.successColor : tc.textSecondary,
              size: 28,
            ),
              SizedBox(width: 12.width),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Expanded(
                        child: Text(
                          phase.title,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w700,
                            color: tc.textPrimary,
                          ),
                        ),
                      ),
                  ProjectStatusBadge(status: phase.status),

                    ],
                  ),
                  SizedBox(height: 4.height),
                  Text(
                    phase.description,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: tc.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
