import 'package:flutter/material.dart';
import '../../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/functions/translation.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../shared/models/project_phase_model.dart';

class ProjectPhasesSectionWidget extends StatelessWidget {
  const ProjectPhasesSectionWidget({
    super.key,
    required this.phases,
    required this.isManager,
  });

  final List<ProjectPhaseModel> phases;
  final bool isManager;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return OutlinedSection(
      title: AppStrings.projectPhasesSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Table(
            columnWidths: isManager
                ? {
                    0: const FlexColumnWidth(2),
                    1: const FlexColumnWidth(2),
                    2: const FlexColumnWidth(1.5),
                  }
                : {0: const FlexColumnWidth(1), 1: const FlexColumnWidth(1)},
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

                  if (isManager)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.height),
                      child: Text(
                        AppStrings.actionHeader,
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
                        phase.name,
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
                        phase.status.trans,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: AppConstant.getStatusColor(phase.status),
                        ),
                      ),
                    ),
                    if (isManager)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 24.width,
                                height: 24.width,
                                decoration: BoxDecoration(
                                  color: colors.primaryBrand,
                                  borderRadius: BorderRadius.circular(6.radius),
                                ),
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 16.width,
                                  color: colors.onPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 7.width),
                            Text(
                              AppStrings.doneLabel,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
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
