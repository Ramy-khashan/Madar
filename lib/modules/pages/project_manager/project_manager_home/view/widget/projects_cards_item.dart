

import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../model/project_model.dart';
import '../../../project_details/view/widgets/project_status_badge.dart';

class ProjectCardItem extends StatelessWidget {
  const ProjectCardItem({super.key, required this.project});
  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: tc.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tc.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageItem(
                project.imageUrl,
                width: 115.width,
                height: 120.width,
                borderRadius: BorderRadius.circular(8),
              ),
              SizedBox(width: 10.width),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 5.height,
                        top: 12.height,
                      ),
                      child: Text(
                        project.name,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          fontWeight: FontWeight.w700,
                          color: tc.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.height),
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
          SizedBox(height: 16.height),
          AppButton(
            text: AppStrings.showDetails,
            onTap: () => RouterHandler.navigate(
              context,
              AppRouterKeys.projectManagerDetails,
              extra: project,
            ),
          ),
        ],
      ),
    );
  }
}
 