import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/components/loading_process.dart';

import '../../../../../config/router/app_router_keys.dart';
import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../controller/project_details_bloc.dart';
import 'widgets/project_phase_row.dart';
import 'widgets/project_summary_card.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: tc.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.project),
      body: SafeArea(
        child: BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
          builder: (context, state) {
            final project = state.project;
            return LoadingProcess(
              status: state.status,
              errorMsg: state.errorMessage,
              onTapRefresh: () {
                ProjectDetailsBloc.get(context).add(
                  ProjectDetailsLoad(projectId: project?.project?.id ?? ''),
                );
              },
              childIsLoader: true,
              emptyMsg: AppStrings.noDataFound,
              isEmptyList: state.project == null,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.width,
                  vertical: 12.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProjectSummaryCard(project: project, tc: tc),
                    SizedBox(height: 24.height),
                    Text(
                      AppStrings.projectPhasesSection,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(18),
                        fontWeight: FontWeight.w700,
                        color: tc.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16.height),
                    ...(project?.stages ?? []).map(
                      (phase) => Padding(
                        padding: EdgeInsets.only(bottom: 12.height),
                        child: ProjectPhaseRow(
                          onTap: () {
                            RouterHandler.navigate(
                              context,
                              AppRouterKeys.phaseDetails,
                              extra: {
                                'phase': phase,
                                'timeline': project?.timeline ?? [],
                                'projectId': project?.project?.id ?? '',
                              },
                            ).then((val) {
                              if (val == true && context.mounted) {
                                ProjectDetailsBloc.get(context).add(
                                  ProjectDetailsLoad(
                                    projectId: project?.project?.id ?? '',
                                  ),
                                );
                              }
                            });
                          },
                          phase: phase,
                          timeline: project?.timeline ?? [],
                          projectId: project?.project?.id ?? '',
                          tc: tc,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
