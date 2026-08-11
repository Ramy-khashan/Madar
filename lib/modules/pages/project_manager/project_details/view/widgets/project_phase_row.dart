import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
import '../../../../business/real_estate_development/business_project_details/model/real_state_project_model.dart';
import 'project_status_badge.dart';

class ProjectPhaseRow extends StatelessWidget {
  const ProjectPhaseRow({
    super.key,
    required this.onTap,
    required this.phase,
    required this.timeline,
    required this.projectId,
    required this.tc,
  });
  final VoidCallback? onTap;
  final ProjectStages phase;
  final List<Timeline> timeline;
  final String projectId;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    final isCompleted = phase.progress == 100;
    return GestureDetector(
      onTap: onTap,
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
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.check_circle_outline_rounded,
                  color: isCompleted
                      ? AppColors.successColor
                      : tc.textSecondary,
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
                              phase.stageName ?? 'Phase Name',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                fontWeight: FontWeight.w700,
                                color: tc.textPrimary,
                              ),
                            ),
                          ),
                          ProjectStatusBadge(
                            status: (phase.status ?? 'in_progress')
                                .toLowerCase()
                                .trans,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.height),
                      Text(
                        phase.description ?? 'Phase Description',
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
            SizedBox(height: 8.height),
            Row(
              children: [
                Text(
                  AppStrings.progress,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: tc.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  '%${(phase.progress ?? 0)}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    fontWeight: FontWeight.w700,
                    color: tc.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.height),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (double.parse((phase.progress ?? 0).toString()) / 100),
                backgroundColor: tc.borderColor.withValues(alpha: 0.5),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.successColor,
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
