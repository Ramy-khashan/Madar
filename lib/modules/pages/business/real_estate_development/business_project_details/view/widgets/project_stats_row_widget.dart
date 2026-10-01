import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import 'stat_card.dart';

class ProjectStatsRowWidget extends StatelessWidget {
  const ProjectStatsRowWidget({
    super.key,
    required this.inProgressCount,
    required this.delayedCount,
  });

  final int inProgressCount;
  final int delayedCount;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Row(
      children: [
        Expanded(
          child: StatCard(
            label: AppStrings.phasesInProgress,
            count: inProgressCount,
            colors: colors,
          ),
        ),
        SizedBox(width: 12.width),
        Expanded(
          child: StatCard(
            label: AppStrings.phasesDelayed,
            count: delayedCount,
            colors: colors,
          ),
        ),
      ],
    );
  }
}
