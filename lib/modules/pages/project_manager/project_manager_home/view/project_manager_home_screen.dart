import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../controller/project_manager_home_bloc.dart';
import 'widget/profile_sheet.dart';
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${AppStrings.hello} ${sl.get<PreferenceUtils>().getString(StorageKeys.name)}',
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
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => ProfileBottomSheet(
                          userName:
                              '${AppStrings.hello} ${sl.get<PreferenceUtils>().getString(StorageKeys.name)}',
                        ),
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_down, size: 32.width),
                  ),

                  CircleAvatar(
                    backgroundColor: const Color(0xFFE0E0E0),
                    radius: 24.width,
                    child: Icon(Icons.person, color: tc.primaryBrand),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<ProjectManagerHomeBloc, ProjectManagerHomeState>(
                    builder: (context, state) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          ProjectManagerHomeBloc.get(
                            context,
                          ).add(const ProjectManagerHomeLoad());
                        },
                        child: LoadingProcess(
                          status: state.loadingStatus,
                          errorMsg: state.errorMsg,
                          onTapRefresh: () {
                            ProjectManagerHomeBloc.get(
                              context,
                            ).add(const ProjectManagerHomeLoad());
                          },
                          childIsLoader: true,
                          emptyMsg: AppStrings.noProjectsExist,
                          isEmptyList: state.projects.isEmpty,
                          child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: ResponsiveUtils.types(
                                context,
                                mobilePortrait: 1,
                                mobileLandscape: 2,
                                tabletPortrait: 2,
                                tabletLandscape: 3,
                              ).toInt(),
                              mainAxisExtent: ResponsiveUtils.types(
                                context,
                                mobilePortrait: 215.height,
                                mobileLandscape: 230.height,
                                tabletPortrait: 160.height,
                                tabletLandscape: 220.height,
                              ),
                              crossAxisSpacing: 12.width,
                              mainAxisSpacing: 12.height,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.width,
                              vertical: 12.height,
                            ),
                            itemCount:
                                state.loadingStatus == RequestStatus.loading
                                ? 10
                                : state.projects.length,
                          
                            itemBuilder: (context, i) {
                              return ProjectCardItem(
                                project:
                                    state.loadingStatus == RequestStatus.loading
                                    ? null
                                    : state.projects[i],
                              );
                            },
                          ),
                        ),
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
