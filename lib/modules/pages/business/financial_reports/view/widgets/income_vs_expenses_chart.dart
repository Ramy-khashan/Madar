import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../model/financial_report_models.dart';

class IncomeVsExpensesChart extends StatelessWidget {
  const IncomeVsExpensesChart({
    super.key,
    required this.colors,
    required this.points,
  });

  final AppThemeColors colors;
  final List<IncomeVsExpenseItem> points;

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return const SizedBox.shrink();
    }
    final maxVal = points
        .map((item) => item.income > item.expense ? item.income : item.expense)
        .fold<double>(1, (a, b) => a > b ? a : b);
    return OutlinedSection(
      title: AppStrings.incomeVsExpenses,

      child: SizedBox(
        height: 145.height,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(points.length, (i) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.width),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              height: (points[i].income / maxVal) * 100.height,
                              decoration: BoxDecoration(
                                color: const Color(0xFF26C6DA),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(3.radius),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 1.width),
                          Expanded(
                            child: Container(
                              height: (points[i].expense / maxVal) * 100.height,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6C63FF),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(3.radius),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 8.height),
            Row(
              children: List.generate(points.length, (i) {
                return Expanded(
                  child: Text(
                    AppStrings.dashboardMonthShortLabel(points[i].month),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(10),
                      color: colors.textSecondary,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
