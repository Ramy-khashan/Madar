import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../individual/property_details/model/property_details_model.dart';
import 'owner_financial_stat_tile.dart';

class OwnerFinancialSection extends StatelessWidget {
  const OwnerFinancialSection({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final expenseTotal = (property?.expenses ?? []).fold<double>(
      0,
      (sum, e) => sum + (e.amount ?? 0).toDouble(),
    );
    final income = (property?.financialPerformance?.monthlyIncome ?? 0)
        .toDouble();
    final net = income - expenseTotal;
    if (income == 0 && expenseTotal == 0) return const SizedBox.shrink();

    return Column(
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
                label: AppStrings.income,
                amount: income,
                color: AppColors.successColor,
              ),
            ),
            SizedBox(width: 8.width),
            Expanded(
              child: OwnerFinancialStatTile(
                label: AppStrings.expenses,
                amount: expenseTotal,
                color: AppColors.errorColor,
              ),
            ),
            SizedBox(width: 8.width),
            Expanded(
              child: OwnerFinancialStatTile(
                label: AppStrings.netProfit,
                amount: net,
                color: colors.primaryBrand,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

