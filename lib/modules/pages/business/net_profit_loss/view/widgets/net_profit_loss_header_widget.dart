import 'package:flutter/material.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../controller/net_profit_loss_bloc.dart';

class NetProfitLossHeaderWidget extends StatelessWidget {
  const NetProfitLossHeaderWidget({super.key, required this.state});

  final NetProfitLossState state;
 
  @override
  Widget build(BuildContext context) {
    final isPositive = state.profitChange >= 0;
    return Container(
      margin: EdgeInsets.all(16.width),
      padding: EdgeInsets.all(20.width),
      decoration: BoxDecoration(
        color: AppColors.successColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(
          color: AppColors.successColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.netProfitPeriodLabel,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: AppColors.successColor,
            ),
          ),
          SizedBox(height: 6.height),
          Text(
            '${formatPrice(state.netProfit)} ر.س',
            style: TextStyle(
              fontSize: context.responsiveFontScale(36),
              fontWeight: FontWeight.w800,
              color: AppColors.darkGreenColor,
            ),
          ),
          SizedBox(height: 8.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImageItem(
                AppImages.occupancyIcon,
                color: AppColors.successColor,
              ),
              SizedBox(width: 6.width),

              Text(
                '${isPositive ? '+' : ''}${state.profitChangePercent.toStringAsFixed(0)}٪ ${AppStrings.comparedToPrevMonth}',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: AppColors.successColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.height),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  label: AppStrings.totalIncomeLabel,
                  value: formatPrice(state.annualProfit),
                ),
              ),
               SizedBox(width: 12.width),

              Expanded(
                child: _SummaryTile(
                  label: AppStrings.totalExpensesLabel,
                  value: formatPrice(state.totalExpenses),
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(24),
            fontWeight: FontWeight.w700,
            color: AppColors.darkGreenColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(12),
            color: AppColors.successColor,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}
