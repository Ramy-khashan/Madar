import 'package:flutter/material.dart';
import '../../../../../../../core/components/outline_section.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/translation.dart';
import '../../model/real_state_project_model.dart';

class ProjectPhasesSectionWidget extends StatelessWidget {
  const ProjectPhasesSectionWidget({super.key, required this.phases});

  final List<ProjectStages> phases;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return OutlinedSection(
      title: AppStrings.projectPhasesSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Table(
            columnWidths: {
              0: const FlexColumnWidth(1),
              1: const FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: colors.borderColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.radius),
                    topRight: Radius.circular(12.radius),
                  ),
                  border: Border(bottom: BorderSide(color: colors.borderColor)),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.height),
                    child: Text(
                      AppStrings.phaseHeader,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.textFieldTitle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.height),
                    child: Text(
                      AppStrings.statusHeader,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.textFieldTitle,
                      ),
                    ),
                  ),
                ],
              ),
              ...phases.map(
                (phase) => TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: colors.borderColor),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.height),
                      child: Text(
                        phase.stageName ?? 'Phase Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.height),
                      child: Text(
                        (phase.status ?? 'IN_PROGRESS').toLowerCase().trans,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: AppConstant.getStatusColor(
                            phase.status ?? 'IN_PROGRESS',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (phases.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.height),
              child: Text(
                AppStrings.noPhasesRegistered,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
