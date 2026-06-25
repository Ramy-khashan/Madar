import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../model/statistic_circle_model.dart';
import '../utils/functions/responsive.dart';
import 'outline_section.dart';

class StatisticCircleShapeItem extends StatefulWidget {
  const StatisticCircleShapeItem({
    required this.title,
    required this.sections,
    required this.colors,
    super.key,
  });

  final String title;
  final List<StatisticCircleModel> sections;
  final AppThemeColors colors;

  @override
  State<StatisticCircleShapeItem> createState() =>
      _StatisticCircleShapeItemState();
}

class _StatisticCircleShapeItemState extends State<StatisticCircleShapeItem> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return OutlinedSection(
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: ResponsiveUtils.types(
              context,
              mobilePortrait: 1,
              mobileLandscape: 2.5,
              tabletPortrait: 3.2,
              tabletLandscape: 3.2,
            ),
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 30.width,
                sections: _showingSections(),
              ),
            ),
          ),
          SizedBox(height: 16.height),
          ...widget.sections.map(
            (val) => Padding(
              padding: EdgeInsets.only(bottom: 4.height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 10.width,
                    height: 10.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: val.color,
                    ),
                  ),
                  SizedBox(width: 6.width),
                  Expanded(
                    child: Text(
                      val.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        color: widget.colors.textFieldTitle,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(widget.sections.length, (i) {
      final isTouched = i == touchedIndex;
      final section = widget.sections[i];
      return PieChartSectionData(
        color: section.color,
        value: section.value * 100,
        title: '${(section.value * 100).toStringAsFixed(0)}%',
        radius: isTouched ? 45.width : 35.width,
        titleStyle: TextStyle(
          fontSize: context.responsiveFontScale(11),
          fontWeight: FontWeight.bold,
          color: widget.colors.textPrimary,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }
}
