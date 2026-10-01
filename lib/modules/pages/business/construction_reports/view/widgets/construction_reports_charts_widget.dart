import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/outline_section.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/construction_reports_bloc.dart';

class ConstructionReportsLineChartWidget extends StatelessWidget {
  const ConstructionReportsLineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ConstructionReportsBloc, ConstructionReportsState>(
      buildWhen: (p, c) => p.report != c.report,
      builder: (context, state) {
        final points = state.report.occupancyOverTime;
        if (points.isEmpty) return const SizedBox.shrink();
        final values = points.map((e) => e.occupancyRate).toList();
        final maxVal = values.fold<double>(0, (a, b) => a > b ? a : b);
        const minY = 0.0;
        final maxY = maxVal <= 0 ? 100.0 : (maxVal <= 100 ? 100.0 : maxVal);
        return OutlinedSection(
          title: AppStrings.occupancyOverTime,
          child: SizedBox(
            height: 160.height,
            child: LineChart(
              LineChartData(
                minY: minY,
                maxY: maxY,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxY / 4,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: colors.borderColor, strokeWidth: 0.5),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(10),
                            color: colors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 2,
                      getTitlesWidget: (value, meta) {
                        final idx = value.toInt();
                        if (idx < 0 || idx >= points.length || idx % 2 != 0) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 4.height),
                          child: Text(
                            AppStrings.dashboardMonthLabel(points[idx].month),
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(9),
                              color: colors.textSecondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                      values.length,
                      (i) => FlSpot(i.toDouble(), values[i]),
                    ),
                    color: AppColors.rate,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.rate.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
