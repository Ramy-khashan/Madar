import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/account_role.dart';
import '../../../../../../core/utils/functions/print_state.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../individual/property_details/model/property_details_model.dart';
import 'owner_financial_stat_tile.dart';

class OwnerFinancialSection extends StatelessWidget {
  const OwnerFinancialSection({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    if (!AccountRole.isBusiness) return const SizedBox.shrink();
    final colors = AppThemeColors.of(context);
    final performance = property?.financialPerformance;
    if (performance == null) return const SizedBox.shrink();
printState( property?.type == 'BUILDING');
    return property?.type == 'BUILDING'
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.financialPerformance,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              SizedBox(height: 12.height),
              Row(
                children: [
                    Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.activeUnits,
                      valueText: '${performance.activeChildUnits ?? 0}',
                      color: AppColors.successColor,
                    ),
                  ),
                
                  SizedBox(width: 8.width),
                       Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.occupancyRate,
                      valueText: performance.occupancyRateLabel,
                      color: AppColors.rate,
                    ),
                  ),
                  // Expanded(
                  //   child: OwnerFinancialStatTile(
                  //     label: AppStrings.totalUnits,
                  //     valueText: '${performance.totalChildUnits ?? 0}',
                  //     color: colors.primaryBrand,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 8.height),
              // Row(
              //   children: [
              //     Expanded(
              //       child: OwnerFinancialStatTile(
              //         label: AppStrings.occupancyRate,
              //         valueText: performance.occupancyRateLabel,
              //         color: AppColors.rate,
              //       ),
              //     ),
              //     SizedBox(width: 8.width),
              //     Expanded(
              //       child: OwnerFinancialStatTile(
              //         label: AppStrings.yearlyIncome,
              //         amount: performance.totalIncome?.toDouble(),
              //         color: AppColors.successColor,
              //       ),
              //     ),
              //   ],
              // ),
                Row(
                children: [
                  Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.totalIncomeLabel,
                      valueText: performance.totalIncome?.toString() ?? '0',
                      color: AppColors.successColor,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.totalExpensesLabel,
                      valueText: performance.totalExpenses?.toString() ?? '0',
                      color: AppColors.errorColor,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.netProfit,
                      valueText: performance.netProfit?.toString() ?? '0',
                      color: AppColors.grey800,
                    ),
                  ),
                ],
              ),

            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.financialPerformance,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
              SizedBox(height: 12.height),
              Row(
                children: [
                  Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.totalIncomeLabel,
                      valueText: performance.totalIncome?.toString() ?? '0',
                      color: AppColors.successColor,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.totalExpensesLabel,
                      valueText: performance.totalExpenses?.toString() ?? '0',
                      color: AppColors.errorColor,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    child: OwnerFinancialStatTile(
                      label: AppStrings.netProfit,
                      valueText: performance.netProfit?.toString() ?? '0',
                      color: AppColors.grey800,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
