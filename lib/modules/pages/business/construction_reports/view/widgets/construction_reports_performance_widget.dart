import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
 import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../financial_reports/view/widgets/shared/financial_metric_card.dart';
import '../../controller/construction_reports_bloc.dart';

class ConstructionReportsPerformanceWidget extends StatelessWidget {
  const ConstructionReportsPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ConstructionReportsBloc, ConstructionReportsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.width,
            vertical: 8.height,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.performanceOverview,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  color: colors.textFieldTitle,
                ),
              ),
              SizedBox(height: 12.height),
              Row(
                children: [
                  Expanded(
                    child: FinancialMetricCard(
                      label: AppStrings.activeContractsLabel,
                      value: '${state.activeContracts}',
                      icon: AppImages.documentsIcon,
                      colors: colors,
                      valueColor: colors.primaryBrand,
                    ),
                  ),
                  SizedBox(width: 12.width),
                  Expanded(
                    child: FinancialMetricCard(
                      label: AppStrings.occupancyRate,
                      value:
                          '${(state.occupancyRate * 100).toStringAsFixed(0)}%',
                      icon: AppImages.occupancyIcon,
                      colors: colors,
                      valueColor: colors.primaryBrand,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.height),
              SizedBox(
                height: 90.height,
                child: FinancialMetricCard(
                  isStartedTextVal: true,
                  label: AppStrings.monthlyIncome,
                  value: '${_formatNumber(state.monthlyIncome)} ر.س',
                  icon: AppImages.monthlyIncomeIcon,
                  colors: colors,
                  valueColor: colors.primaryBrand,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatNumber(double value) {
    if (value >= 1000) {
      return value
          .toStringAsFixed(0)
          .replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (m) => '${m[1]},',
          );
    }
    return value.toStringAsFixed(0);
  }
}
