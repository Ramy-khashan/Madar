import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/statistic_circle_shape_item.dart';
import '../../controller/financial_reports_bloc.dart';
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
          p.incomeSections != c.incomeSections ||
          p.expensesSections != c.expensesSections,
      builder: (context, state) {
        return SingleChildScrollView(
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

                      value: formatPrice(state.totalExpenses),
                      icon: AppImages.finalPriceIcon,
                      valueColor: AppColors.primary300,
                      colors: colors,
                    ),
                  ),
                  SizedBox(width: 12.width),
                  Expanded(
                    child: FinancialMetricCard(
                      label: AppStrings.expenses,

                      value: formatPrice(state.totalIncome),
                      icon: AppImages.finalPriceIcon,
                      valueColor: AppColors.orangeColor,
                      colors: colors,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.height),
              Row(
                children: [
                  Expanded(
                    child: FinancialMetricCard(
                      label: AppStrings.netProfit,
                      value: formatPrice(state.netProfit),
                      icon: AppImages.finalPriceIcon,
                      valueColor: AppColors.successColor,
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
              _IncomeVsExpensesChart(colors: colors),
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
  final List tenants;

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
  const _IncomeVsExpensesChart({required this.colors});

  final AppThemeColors colors;

  static const List<double> _income = [
    60,
    100,
    80,
    110,
    70,
    130,
    90,
    80,
    110,
    60,
  ];
  static const List<double> _expenses = [
    40,
    60,
    50,
    70,
    45,
    90,
    55,
    50,
    70,
    40,
  ];

  @override
  Widget build(BuildContext context) {
    final maxVal = [..._income, ..._expenses].reduce((a, b) => a > b ? a : b);
    return OutlinedSection(
      title: AppStrings.incomeVsExpenses,
    
      child: SizedBox(
        height: 120.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(_income.length, (i) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.width),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        height: (_income[i] / maxVal) * 110.height,
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
                        height: (_expenses[i] / maxVal) * 110.height,
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
    );
  }
}
