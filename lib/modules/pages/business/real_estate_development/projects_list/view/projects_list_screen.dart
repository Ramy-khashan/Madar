import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/loading_process.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../controller/projects_list_bloc.dart';
import 'widgets/project_list_item_widget.dart';
import 'widgets/project_type_selection_dialog.dart';

class ProjectsListScreen extends StatelessWidget {
  const ProjectsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.realEstateDevelopment),
      body: BlocBuilder<ProjectsListBloc, ProjectsListState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppStrings.realEstateDevelopmentProjects,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(18),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                      SizedBox(height: 4.height),
                      Text(
                        AppStrings.ownerProjectsViewOnly,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LoadingProcess(
                    status: state.status,
                    errorMsg: state.errorMessage,
                    onTapRefresh: () {
                      ProjectsListBloc.get(context).add(const ProjectsListLoad());
                    },
                    emptyMsg: AppStrings.noProjectsExist,
                    isEmptyList: state.projects.isEmpty,
                    childIsLoader: true,
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.width,
                        vertical: 4.height,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveUtils.types(
                          context,
                          mobilePortrait: 1,
                          mobileLandscape: 2,
                          tabletPortrait: 2,
                          tabletLandscape: 3,
                        ).toInt(),
                        mainAxisSpacing: 12.height,
                        mainAxisExtent: ResponsiveUtils.types(
                          context,
                          mobilePortrait: 250,
                          mobileLandscape: 220,
                          tabletPortrait: 300,
                          tabletLandscape: 320,
                        ).toDouble(),
                      ),
                      itemCount: state.status == RequestStatus.loading ? 10:state.projects.length ,
                      itemBuilder: (_, i) => ProjectListItemWidget(
                        project: state.status == RequestStatus.loading ? null : state.projects[i],
                       ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  child: AppButton(
                    text: AppStrings.addProject,
                    onTap: () =>
                        showDialog(
                          context: context,
                          builder: (_) => const ProjectTypeSelectionDialog(),
                        ).then((val) {
                          if (val != null) {
                            if (context.mounted) {
                              if (val == AppConstant.residentialProjectType) {
                                RouterHandler.navigate(
                                  context,
                                  AppRouterKeys.realEstateDevelopmentAddProject,
                                );
                              } else if (val == AppConstant.commercialProjectType) {
                                RouterHandler.navigate(
                                  context,
                                  AppRouterKeys
                                      .realEstateDevelopmentAddCommercial,
                                );
                              }
                              // context.push(AppRouterKeys.addProject, extra: val);
                            }
                          }
                        }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
    