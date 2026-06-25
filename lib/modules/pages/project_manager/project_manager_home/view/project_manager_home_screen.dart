import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/project_manager_home_bloc.dart';
import 'widget/projects_cards_item.dart';

class ProjectManagerHomeScreen extends StatelessWidget {
  const ProjectManagerHomeScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: tc.backgroundPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                20.width,
                20.height,
                20.width,
                8.height,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.hello} أحمد',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(24),
                      fontWeight: FontWeight.w800,
                      color: tc.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.height),
                  Text(
                    AppStrings.projectsAssigned,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: tc.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<ProjectManagerHomeBloc, ProjectManagerHomeState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: tc.primaryBrand,
                          ),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.width,
                          vertical: 12.height,
                        ),
                        itemCount: state.projects.length,
                        separatorBuilder: (_, _) => SizedBox(height: 12.height),
                        itemBuilder: (context, i) {
                          return ProjectCardItem(project: state.projects[i]);
                        },
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
