import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class ConstructionReportsLineChartWidget extends StatelessWidget {
  const ConstructionReportsLineChartWidget({super.key});

  static const List<double> _data = [
    22.0,
    22.5,
    24.0,
    25.5,
    24.5,
    25.0,
    23.5,
    22.0,
    23.0,
    22.5,
  ];
  static const List<String> _xLabels = ['يناير', 'فبراير', 'مارس', 'أبريل'];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return OutlinedSection(
      title: AppStrings.occupancyOverTime,

      child: SizedBox(
        height: 160.height,
        child: LineChart(
          LineChartData(
            minY: 20,
            maxY: 27,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
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
                  interval: 1,
                  
                  getTitlesWidget: (value, meta) {
                    if (value % 1 != 0) return const SizedBox.shrink();
                    return Text(
                      value.toStringAsFixed(0),
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
                  interval: 3,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    const labels = _xLabels;
                    final labelIdx = (idx ~/ 3);
                    if (labelIdx >= labels.length) {
                      return const SizedBox.shrink();
                    }
                    if (idx % 3 != 0) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.only(top: 4.height),
                      child: Text(
                        labels[labelIdx],
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(10),
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
                  _data.length,
                  (i) => FlSpot(i.toDouble(), _data[i]),
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
  }
}

class ConstructionReportsBarChartWidget extends StatelessWidget {
  const ConstructionReportsBarChartWidget({super.key});

  static const List<double> _data = [
    80,
    110,
    60,
    90,
    50,
    70,
    100,
    80,
    100,
    60,
    90,
    110,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    final maxVal = _data.reduce((a, b) => a > b ? a : b);
    return OutlinedSection(
      title: AppStrings.contractsMovement,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120.height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(_data.length, (i) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.width),
                    child: Container(
                      height: (_data[i] / maxVal) * 100.height,
                      decoration: BoxDecoration(
                        color: AppColors.secondBrand.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(3.radius),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 6.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_data.length, (i) {
              return Text(
                '${i + 1}',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(9),
                  color: colors.textSecondary,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
