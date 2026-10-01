import 'package:flutter/material.dart';

import '../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/net_profit_loss_bloc.dart';
import 'comparison_row.dart';

class NetProfitLossComparisonWidget extends StatelessWidget {
  const NetProfitLossComparisonWidget({super.key, required this.state});

  final NetProfitLossState state;

  @override
  Widget build(BuildContext context) {
    return OutlinedSection(
      title: AppStrings.comparisonWithPrevPeriod,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ComparisonRow(
            label: AppStrings.income,
            item: state.incomeComparison,
            positiveColor: AppColors.successColor,
          ),
          SizedBox(height: 8.height),
          ComparisonRow(
            label: AppStrings.expenses,
            item: state.expensesComparison,
            positiveColor: AppColors.errorColor,
          ),
          SizedBox(height: 8.height),
          ComparisonRow(
            label: AppStrings.netProfit,
            item: state.netProfitComparison,
            positiveColor: AppColors.secondBrand,
          ),
        ],
      ),
    );
  }
}
