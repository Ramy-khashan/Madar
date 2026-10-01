import 'package:flutter/material.dart';
import '../../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../model/real_state_project_model.dart';
import 'timeline_item.dart';

class ProjectTimelineSectionWidget extends StatelessWidget {
  const ProjectTimelineSectionWidget({super.key, required this.timeline});

  final List<Timeline> timeline;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return OutlinedSection(
      title: AppStrings.timelineUpdatesSection,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (timeline.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.height),
              child: Text(
                AppStrings.noTimelineUpdates,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            )
          else
            ...List.generate(timeline.length, (i) {
              final item = timeline[i];
              return TimelineItem(index: i + 1, item: item, colors: colors);
            }),
        ],
      ),
    );
  }
}
