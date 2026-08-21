import 'package:flutter/material.dart';

import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/net_profit_loss_bloc.dart';
import '../../model/profit_loss_model.dart';

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
          _ComparisonRow(
            label: AppStrings.income,
            item: state.incomeComparison,
            positiveColor: AppColors.successColor,
          ),
          SizedBox(height: 8.height),
          _ComparisonRow(
            label: AppStrings.expenses,
            item: state.expensesComparison,
            positiveColor: AppColors.errorColor,
          ),
          SizedBox(height: 8.height),
          _ComparisonRow(
            label: AppStrings.netProfit,
            item: state.netProfitComparison,
            positiveColor: AppColors.secondBrand,
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.label,
    required this.item,
    required this.positiveColor,
  });

  final String label;
  final ProfitLossComparisonItem item;
  final Color positiveColor;

  @override
  Widget build(BuildContext context) {
    final isUp = item.percent >= 0;
    final color = isUp ? positiveColor : AppColors.errorColor;
    final amountSign = item.amount > 0 ? '+' : '';
    final percentSign = item.percent > 0 ? '+' : '';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.radius),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Row(
            children: [
              ImageItem(AppImages.occupancyIcon, color: color),
              SizedBox(width: 12.width),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$amountSign${formatPrice(item.amount)} ${AppStrings.currency}',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                  SizedBox(height: 4.height),
                  Text(
                    '$percentSign${item.percent.toStringAsFixed(0)}٪',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: AppThemeColors.of(context).textFieldTitle,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
