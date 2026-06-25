import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class ProjectPhaseEntry {
  final String title;
  final String subtitle;
  final List<String> tasks;

  const ProjectPhaseEntry({
    required this.title,
    required this.subtitle,
    this.tasks = const [],
  });
}

class ProjectPhasesChecklistWidget extends StatefulWidget {
  const ProjectPhasesChecklistWidget({
    super.key,
    required this.label,
    required this.subtitle,
    required this.phases,
  });

  final String label;
  final String subtitle;
  final List<ProjectPhaseEntry> phases;

  @override
  State<ProjectPhasesChecklistWidget> createState() =>
      _ProjectPhasesChecklistWidgetState();
}

class _ProjectPhasesChecklistWidgetState
    extends State<ProjectPhasesChecklistWidget> {
  int _expandedIndex = 0;
  late List<Set<int>> _checkedTasks;
  late List<TextEditingController> _otherControllers;

  @override
  void initState() {
    super.initState();
    _checkedTasks = List.generate(widget.phases.length, (_) => {});
    _otherControllers = List.generate(
      widget.phases.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final c in _otherControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 14.height, bottom: 4.height),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w500,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ),
        Text(
          widget.subtitle,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            color: colors.textSecondary,
            fontFamily: AppConstant.appFont,
          ),
        ),
        SizedBox(height: 12.height),
        ...List.generate(widget.phases.length, (i) {
          final phase = widget.phases[i];
          final isExpanded = _expandedIndex == i;
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
                      onTap: () => setState(
                        () => _expandedIndex = isExpanded ? -1 : i,
                      ),
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
                                    phase.title,
                                    style: TextStyle(
                                      fontSize:
                                          context.responsiveFontScale(14),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConstant.appHeaderFont,
                                      color: colors.textFieldTitle,
                                    ),
                                  ),
                                  if (phase.subtitle.isNotEmpty)
                                    Text(
                                      phase.subtitle,
                                      style: TextStyle(
                                        fontSize:
                                            context.responsiveFontScale(12),
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
                        padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 4.height),
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
                           
                            ...List.generate(phase.tasks.length, (j) {
                              return CheckboxListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: _checkedTasks[i].contains(j),
                                activeColor: colors.primaryBrand,
                                onChanged: (v) => setState(() {
                                  if (v == true) {
                                    _checkedTasks[i].add(j);
                                  } else {
                                    _checkedTasks[i].remove(j);
                                  }
                                }),
                                title: Text(
                                  phase.tasks[j],
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    color: colors.textFieldTitle,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                              );
                            }),
                             Text(
                                'أخرى',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(14),
                                  color: colors.textFieldTitle,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                            SizedBox(height: 12.height),
                            TextField(
                              controller: _otherControllers[i],
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textFieldTitle,
                                fontFamily: AppConstant.appFont,
                              ),
                              decoration: InputDecoration(
                                hintText: 'اكتب مرحلة أخرى تريدها',
                                hintStyle: TextStyle(
                                  fontSize: context.responsiveFontScale(13),
                                  color: colors.textSecondary,
                                  fontFamily: AppConstant.appFont,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.radius),
                                  borderSide:
                                      BorderSide(color: colors.borderColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.radius),
                                  borderSide:
                                      BorderSide(color: colors.borderColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.radius),
                                  borderSide: BorderSide(
                                    color: colors.primaryBrand,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.width,
                                  vertical: 8.height,
                                ),
                              ),
                            ),
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
