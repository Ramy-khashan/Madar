import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/statistic_circle_shape_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../controller/financial_reports_bloc.dart';
import 'shared/financial_metric_card.dart';
import 'late_tenants_card.dart';
import 'income_vs_expenses_chart.dart';
import 'overview_transactions.dart';

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
          p.expensesSections != c.expensesSections ||
          p.transactions != c.transactions,
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
                      isWithCurrency: true,

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
                      isWithCurrency: true,
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
                        isWithCurrency: true,

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
                        isWithCurrency: true,

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
                LateTenantsCard(colors: colors, tenants: state.lateTenants),
                SizedBox(height: 16.height),
              ] else ...[
                FinancialMetricCard(
                  isWithCurrency: true,

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
              IncomeVsExpensesChart(
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
              if (state.transactions.isNotEmpty) ...[
                SizedBox(height: 16.height),
                OverviewTransactions(colors: colors, items: state.transactions),
              ],
            ],
          ),
        );
      },
    );
  }
}
