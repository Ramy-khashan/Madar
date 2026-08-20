import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../models/project_stage_model.dart';

class ProjectPhasesChecklistWidget extends StatelessWidget {
  const ProjectPhasesChecklistWidget({
    super.key,
    required this.label,
    required this.subtitle,
    required this.stages,
    required this.onStageToggled,
    required this.onSubStageToggled,
    required this.selectedStageIds,
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
  final void Function(String stageId, String subStageId) onSubStageToggled;
  final List<String> selectedStageIds;
  final Map<String, List<String>> selectedSubStageIds;
  final Map<String, List<String>> customSubStages;
  final void Function(String stageId, String name)? onCustomSubStageAdded;
  final void Function(String stageId, int index)? onCustomSubStageRemoved;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
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
          final isExpanded = selectedStageIds.contains(stage.id);
          final selectedSubs = selectedSubStageIds[stage.id] ?? [];
          final customForStage = customSubStages[stage.id] ?? [];

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
                    InkWell(
                      onTap: () => onStageToggled(stage.id),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.width,
                          vertical: 12.height,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stage.name,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.appHeaderFont,
                                      color: colors.textFieldTitle,
                                    ),
                                  ),
                                  if (stage.description.isNotEmpty)
                                    Text(
                                      stage.description,
                                      style: TextStyle(
                                        fontSize: context.responsiveFontScale(
                                          12,
                                        ),
                                        color: colors.textSecondary,
                                        fontFamily: AppConstant.appFont,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: colors.textSecondary,
                            ),
                            SizedBox(width: 4.width),
                            Container(
                              width: 18.width,
                              height: 18.width,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isExpanded
                                    ? AppColors.successColor
                                    : Colors.transparent,
                              ),
                              child: isExpanded
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
                          ],
                        ),
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
                                onChanged: (v) =>
                                    onSubStageToggled(stage.id, subStage.id),
                                title: Text(
                                  subStage.name,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    color: colors.textFieldTitle,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                              );
                            }),
                            if (onCustomSubStageAdded != null) ...[
                              ...customForStage.asMap().entries.map(
                                (entry) => ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(14),
                                      color: colors.textFieldTitle,
                                      fontFamily: AppConstant.appFont,
                                    ),
                                  ),
                                  trailing: onCustomSubStageRemoved == null
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
                              _CustomSubStageInput(
                                onAdd: (name) =>
                                    onCustomSubStageAdded!(stage.id, name),
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
  }
}

class _CustomSubStageInput extends StatefulWidget {
  const _CustomSubStageInput({required this.onAdd});

  final ValueChanged<String> onAdd;

  @override
  State<_CustomSubStageInput> createState() => _CustomSubStageInputState();
}

class _CustomSubStageInputState extends State<_CustomSubStageInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    widget.onAdd(name);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 8.height, top: 4.height),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                isDense: true,
                hintText: AppStrings.customSubStageHint,
                hintStyle: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colors.textSecondary,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.textFieldTitle,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ),
          TextButton(
            onPressed: _submit,
            child: Text(AppStrings.addCustomSubStage),
          ),
        ],
      ),
    );
  }
}
