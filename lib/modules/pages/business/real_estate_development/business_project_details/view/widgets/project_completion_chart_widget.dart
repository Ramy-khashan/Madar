import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../../core/components/outline_section.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class ProjectCompletionChartWidget extends StatelessWidget {
  const ProjectCompletionChartWidget({super.key, required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final filled = percentage.clamp(0.0, 100.0);
    final remaining = 100.0 - filled;

    return OutlinedSection(
      title: AppStrings.totalCompletionPercentage,

      child: SizedBox(
        height: 160.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                startDegreeOffset: -90,
                sectionsSpace: 0,
                centerSpaceRadius: 52.radius,
                sections: [
                  PieChartSectionData(
                    value: filled,
                    color: colors.primaryBrand,
                    radius: 22.radius,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: remaining,
                    color: colors.primaryBrand.withValues(alpha: 0.15),
                    radius: 22.radius,
                    showTitle: false,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${filled.toInt()}%',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(22),
                    fontWeight: FontWeight.w800,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.primaryBrand,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
