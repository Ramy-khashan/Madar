import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../model/project_model.dart';
import 'project_status_badge.dart';

class ProjectSummaryCard extends StatelessWidget {
  const ProjectSummaryCard({
    super.key,
    required this.project,
    required this.tc,
  });
  final ProjectModel project;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: tc.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tc.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageItem(
            project.imageUrl,
            width: 115.width,
            height: 120.width,
            borderRadius: BorderRadius.circular(8),
          ),
          SizedBox(width: 12.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 11.height, top: 12.height),
                  child: Text(
                    project.name,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontWeight: FontWeight.w700,
                      color: tc.textPrimary,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: tc.textSecondary,
                          ),
                          SizedBox(width: 4.width),
                          Text(
                            project.location,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(12),
                              color: tc.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ProjectStatusBadge(status: project.status),
                  ],
                ),
                SizedBox(height: 14.height),
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
                      '%${(project.progress * 100).toInt()}',
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
                    value: project.progress,
                    backgroundColor: tc.borderColor.withValues(alpha: 0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.successColor,
                    ),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
