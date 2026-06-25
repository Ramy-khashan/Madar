import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../model/project_model.dart';
import '../controller/project_details_bloc.dart';
import 'widgets/project_phase_row.dart';
import 'widgets/project_summary_card.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key, required this.project});
  final ProjectModel project;

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
            return SingleChildScrollView(
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
                  ...project.phases.map(
                    (phase) => Padding(
                      padding: EdgeInsets.only(bottom: 12.height),
                      child: ProjectPhaseRow(phase: phase, tc: tc),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
