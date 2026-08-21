import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/components/statistic_circle_shape_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../controller/financial_reports_bloc.dart';
import '../../model/financial_report_models.dart';
import 'shared/financial_metric_card.dart';

class FinancialReportsOverviewTabWidget extends StatelessWidget {
  const FinancialReportsOverviewTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<FinancialReportsBloc, FinancialReportsState>(
      buildWhen: (p, c) =>
          p.totalIncome != c.totalIncome ||
          p.netProfit != c.netProfit ||
          p.totalExpenses != c.totalExpenses ||
          p.lateRent != c.lateRent ||
          p.lateTenants != c.lateTenants ||
          p.incomeVsExpense != c.incomeVsExpense ||
          p.incomeSections != c.incomeSections ||
          p.expensesSections != c.expensesSections,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.financialOverview,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(15),
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 12.height),
              Row(
                children: [
                  Expanded(
                    child: FinancialMetricCard(
                      label: AppStrings.totalIncomeLabel,

                      value: formatPrice(state.totalIncome),
                      icon: AppImages.finalPriceIcon,
                      valueColor: AppColors.primary300,
                      colors: colors,
                    ),
                  ),
                  SizedBox(width: 12.width),
                  Expanded(
                    child: FinancialMetricCard(
                      label: AppStrings.expenses,

                      value: formatPrice(state.totalExpenses),
                      icon: AppImages.finalPriceIcon,
                      valueColor: AppColors.orangeColor,
                      colors: colors,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.height),
              if (state.lateRent > 0 || state.lateTenants.isNotEmpty) ...[
                Row(
                  children: [
                    Expanded(
                      child: FinancialMetricCard(
                        label: AppStrings.netProfit,
                        value: formatPrice(state.netProfit),
                        icon: AppImages.finalPriceIcon,
                        valueColor: state.netProfit >= 0
                            ? AppColors.successColor
                            : AppColors.errorColor,
                        colors: colors,
                      ),
                    ),
                    SizedBox(width: 12.width),
                    Expanded(
                      child: FinancialMetricCard(
                        label: AppStrings.lateRentLabel,
                        value: formatPrice(state.lateRent),
                        icon: AppImages.finalPriceIcon,
                        valueColor: AppColors.errorColor,
                        colors: colors,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.height),
                _LateTenantsCard(colors: colors, tenants: state.lateTenants),
                SizedBox(height: 16.height),
              ] else ...[
                FinancialMetricCard(
                  label: AppStrings.netProfit,
                  value: formatPrice(state.netProfit),
                  icon: AppImages.finalPriceIcon,
                  valueColor: state.netProfit >= 0
                      ? AppColors.successColor
                      : AppColors.errorColor,
                  colors: colors,
                ),
                SizedBox(height: 16.height),
              ],
              _IncomeVsExpensesChart(
                colors: colors,
                points: state.incomeVsExpense,
              ),
              SizedBox(height: 16.height),
              Row(
                children: [
                  Expanded(
                    child: StatisticCircleShapeItem(
                      title: AppStrings.incomeSources,
                      sections: state.incomeSections,
                      colors: colors,
                    ),
                  ),
                  SizedBox(width: 12.width),
                  Expanded(
                    child: StatisticCircleShapeItem(
                      title: AppStrings.expensesDistribution,
                      sections: state.expensesSections,
                      colors: colors,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LateTenantsCard extends StatelessWidget {
  const _LateTenantsCard({required this.colors, required this.tenants});

  final AppThemeColors colors;
  final List<FinancialTenant> tenants;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: AppColors.rate.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: AppColors.rate.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.latePaymentsLabel} (${tenants.length})',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 10.height),
          ...tenants.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: 8.height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.name,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        t.property,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${t.amount} ${AppStrings.currency}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownColor,
                        ),
                      ),
                      Text(
                        t.days,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IncomeVsExpensesChart extends StatelessWidget {
  const _IncomeVsExpensesChart({required this.colors, required this.points});

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
                final month = AppStrings.dashboardMonthLabel(points[i].month);
                final shortMonth = month.length > 3
                    ? month.substring(0, 3)
                    : month;
                return Expanded(
                  child: Text(
                    shortMonth,
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
