import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/functions/router_handler.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../controller/role_selection_bloc.dart';
import 'widgets/project_type_selection_dialog.dart';
import 'widgets/role_card_widget.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar:   AppAppbar(title: AppStrings.realEstateDevelopment),
      body: BlocBuilder<RoleSelectionBloc, RoleSelectionState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.width,
                      vertical: 8.height,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppStrings.trackRealEstateDevelopment,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(18),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        SizedBox(height: 6.height),
                        Text(
                          AppStrings.trackProjectsSubtitle,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            color: colors.textFieldTitle,
                            fontFamily: AppConstant.appFont,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: 20.height),
                        OutlinedSection(
                          title: AppStrings.roleRedirectNote,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.width),
                            child: Column(
                              children: [
                                RoleCardWidget(
                                  roleKey: 'owner',
                                  title: AppStrings.ownerRoleTitle,
                                  description: AppStrings.ownerRoleDescription,
                                  buttonLabel: AppStrings.enterAsOwner,
                                  icon: AppImages.ownerRoleIcon,
                                  selectedRole: state.selectedRole,
                                  onSelect: () =>
                                      context.read<RoleSelectionBloc>().add(
                                        const RoleSelectionRoleChanged('owner'),
                                      ),
                                  onConfirm: () => RouterHandler.navigate(
                                    context,
                                    AppRouterKeys.realEstateDevelopmentList,
                                    extra: 'owner',
                                  ),
                                ),
                                SizedBox(height: 16.height),
                                RoleCardWidget(
                                  roleKey: 'manager',
                                  title: AppStrings.projectManagerRoleTitle,
                                  description: AppStrings.managerRoleDescription,
                                  buttonLabel: AppStrings.enterAsManager,
                                  icon: AppImages.managerRoleIcon,
                                  selectedRole: state.selectedRole,
                                  onSelect: () =>
                                      context.read<RoleSelectionBloc>().add(
                                        const RoleSelectionRoleChanged(
                                          'manager',
                                        ),
                                      ),
                                  onConfirm: () => RouterHandler.navigate(
                                    context,
                                    AppRouterKeys.realEstateDevelopmentList,
                                    extra: 'manager',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    borderRadius: BorderRadius.circular(32.radius),
                    border: Border.all(color: colors.borderColor),
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
                              if (val == 'residential') {
                                RouterHandler.navigate(
                                  context,
                                  AppRouterKeys.realEstateDevelopmentAddProject,
                                );
                              } else if (val == 'commercial') {
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
