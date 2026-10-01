import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../models/project_stage_model.dart';
import 'custom_sub_stage_input.dart';
import 'expanded_stages_cubit.dart';

class ProjectPhasesChecklistWidget extends StatelessWidget {
  const ProjectPhasesChecklistWidget({
    super.key,
    required this.label,
    required this.subtitle,
    required this.stages,
    required this.onStageToggled,
    this.onStageSelectAll,
    required this.onSubStageToggled,
    required this.selectedSubStageIds,
    this.customSubStages = const {},
    this.onCustomSubStageAdded,
    this.onCustomSubStageRemoved,
    this.isLoading = false,
  });

  final String label;
  final String subtitle;
  final List<ProjectStageModel> stages;
  final void Function(String stageId) onStageToggled;
  final void Function(String stageId)? onStageSelectAll;
  final void Function(String stageId, String subStageId) onSubStageToggled;
  final Map<String, List<String>> selectedSubStageIds;
  final Map<String, List<String>> customSubStages;
  final void Function(String stageId, String name)? onCustomSubStageAdded;
  final void Function(String stageId, int index)? onCustomSubStageRemoved;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpandedStagesCubit(),
      child: BlocBuilder<ExpandedStagesCubit, Set<String>>(
        builder: (context, expandedStageIds) {
          final colors = AppThemeColors.of(context);

          if (isLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.height),
              child: Center(
                child: CircularProgressIndicator(color: colors.primaryBrand),
              ),
            );
          }

          if (stages.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 24.height),
              child: Center(
                child: Text(
                  AppStrings.noProjectStagesAvailable,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 14.height, bottom: 4.height),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w500,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
              SizedBox(height: 12.height),
              ...stages.map((stage) {
                final isExpanded = expandedStageIds.contains(stage.id);
                final selectedSubs = selectedSubStageIds[stage.id] ?? [];
                final customForStage = customSubStages[stage.id] ?? [];
                final selectableSubs = stage.subStages
                    .where((s) => !s.isOther)
                    .toList();
                final allSelectableSelected =
                    selectableSubs.isNotEmpty &&
                    selectableSubs.every((s) => selectedSubs.contains(s.id));
                final isOtherSelected = stage.subStages.any(
                  (s) => s.isOther && selectedSubs.contains(s.id),
                );

                return Container(
                  margin: EdgeInsets.only(bottom: 8.height),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.borderColor),
                    borderRadius: BorderRadius.circular(12.radius),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.radius),
                    child: Material(
                      color: colors.cardBackground,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.width,
                              vertical: 12.height,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => context
                                        .read<ExpandedStagesCubit>()
                                        .toggle(stage.id),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                stage.name,
                                                style: TextStyle(
                                                  fontSize: context
                                                      .responsiveFontScale(14),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      AppConstant.appHeaderFont,
                                                  color: colors.textFieldTitle,
                                                ),
                                              ),
                                              if (stage.description.isNotEmpty)
                                                Text(
                                                  stage.description,
                                                  style: TextStyle(
                                                    fontSize: context
                                                        .responsiveFontScale(
                                                          12,
                                                        ),
                                                    color: colors.textSecondary,
                                                    fontFamily:
                                                        AppConstant.appFont,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up_rounded
                                              : Icons
                                                    .keyboard_arrow_down_rounded,
                                          color: colors.textSecondary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.width),
                                InkWell(
                                  onTap: () =>
                                      (onStageSelectAll ?? onStageToggled)(
                                        stage.id,
                                      ),
                                  customBorder: const CircleBorder(),
                                  child: Container(
                                    width: 22.width,
                                    height: 22.width,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: allSelectableSelected
                                          ? AppColors.successColor
                                          : Colors.transparent,
                                    ),
                                    child: allSelectableSelected
                                        ? Icon(
                                            Icons.check_rounded,
                                            size: 16.width,
                                            color: Colors.white,
                                          )
                                        : ImageItem(
                                            AppImages.trackRequestImage,
                                            color: colors.primaryBrand,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isExpanded)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.width,
                                vertical: 4.height,
                              ),
                              margin: EdgeInsets.only(
                                left: 12.width,
                                right: 12.width,
                                bottom: 12.height,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: colors.borderColor),
                                borderRadius: BorderRadius.circular(8.radius),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ...stage.subStages.map((subStage) {
                                    return CheckboxListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      value: selectedSubs.contains(subStage.id),
                                      activeColor: colors.primaryBrand,
                                      onChanged: (v) => onSubStageToggled(
                                        stage.id,
                                        subStage.id,
                                      ),
                                      title: Text(
                                        subStage.name,
                                        style: TextStyle(
                                          fontSize: context.responsiveFontScale(
                                            14,
                                          ),
                                          color: colors.textFieldTitle,
                                          fontFamily: AppConstant.appFont,
                                        ),
                                      ),
                                    );
                                  }),
                                  if (onCustomSubStageAdded != null &&
                                      isOtherSelected) ...[
                                    ...customForStage.asMap().entries.map(
                                      (entry) => ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          entry.value,
                                          style: TextStyle(
                                            fontSize: context
                                                .responsiveFontScale(14),
                                            color: colors.textFieldTitle,
                                            fontFamily: AppConstant.appFont,
                                          ),
                                        ),
                                        trailing:
                                            onCustomSubStageRemoved == null
                                            ? null
                                            : IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 18.width,
                                                  color: AppColors.errorColor,
                                                ),
                                                onPressed: () =>
                                                    onCustomSubStageRemoved!(
                                                      stage.id,
                                                      entry.key,
                                                    ),
                                              ),
                                      ),
                                    ),
                                    CustomSubStageInput(
                                      onAdd: (name) => onCustomSubStageAdded!(
                                        stage.id,
                                        name,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
