import 'package:flutter/material.dart';

import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../controller/net_profit_loss_bloc.dart';
import 'summary_tile.dart';

class NetProfitLossHeaderWidget extends StatelessWidget {
  const NetProfitLossHeaderWidget({super.key, required this.state});

  final NetProfitLossState state;

  @override
  Widget build(BuildContext context) {
    final isProfit = state.netProfit >= 0;
    final change = state.netProfitComparison.percent;
    final accent = isProfit ? AppColors.successColor : AppColors.errorColor;
    final dark = isProfit ? AppColors.darkGreenColor : AppColors.errorColor;
    final signedChange =
        '${change > 0 ? '+' : ''}${change.toStringAsFixed(0)}٪ ${AppStrings.comparedToPrevMonth}';
    return Container(
      margin: EdgeInsets.all(16.width),
      padding: EdgeInsets.all(20.width),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.netProfitPeriodLabel,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: accent,
            ),
          ),
          SizedBox(height: 6.height),
          Text(
            '${formatPrice(state.netProfit)} ${AppStrings.currency}',
            style: TextStyle(
              fontSize: context.responsiveFontScale(36),
              fontWeight: FontWeight.w800,
              color: dark,
            ),
          ),
          SizedBox(height: 8.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageItem(AppImages.occupancyIcon, color: accent),
              SizedBox(width: 6.width),
              Text(
                signedChange,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: accent,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.height),
          Row(
            children: [
              Expanded(
                child: SummaryTile(
                  label: AppStrings.totalIncomeLabel,
                  value: formatPrice(state.totalIncome),
                  color: dark,
                  captionColor: accent,
                ),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: SummaryTile(
                  label: AppStrings.totalExpensesLabel,
                  value: formatPrice(state.totalExpenses),
                  color: dark,
                  captionColor: accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
