import 'package:flutter/material.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/net_profit_loss_bloc.dart';

class NetProfitLossComparisonWidget extends StatelessWidget {
  const NetProfitLossComparisonWidget({super.key, required this.state});

  final NetProfitLossState state;

  @override
  Widget build(BuildContext context) {
     return OutlinedSection(
      title: 
            AppStrings.comparisonWithPrevPeriod,
      
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          _ComparisonRow(
            label: AppStrings.income,
            amount: 'ر.س +٢٠،٠٠٠',
            percent: '+٢٠٪',
            bgColor: AppColors.successColor.withValues(alpha: 0.08),
            borderColor: AppColors.successColor.withValues(alpha: 0.3),
            valueColor: AppColors.successColor,
            arrowUp: true,
          ),
          SizedBox(height: 8.height),
          _ComparisonRow(
            label: AppStrings.expenses,
            amount: 'ر.س +٥،٠٠٠',
            percent: '+٧٪',
            bgColor: AppColors.errorColor.withValues(alpha: 0.08),
            borderColor: AppColors.errorColor.withValues(alpha: 0.3),
            valueColor: AppColors.errorColor,
            arrowUp: true,
          ),
          SizedBox(height: 8.height),
          _ComparisonRow(
            label: AppStrings.netProfit,
            amount: 'ر.س +١٥،٠٠٠',
            percent: '+٣٠٪',
            bgColor: AppColors.secondBrand.withValues(alpha: 0.08),
            borderColor: AppColors.secondBrand.withValues(alpha: 0.3),
            valueColor: AppColors.secondBrand,
            arrowUp: true,
          ),
        ],
      ),
    );
  }
}

class _ComparisonRow extends StatelessWidget {
  const _ComparisonRow({
    required this.label,
    required this.amount,
    required this.percent,
    required this.bgColor,
    required this.borderColor,
    required this.valueColor,
    required this.arrowUp,
  });

  final String label;
  final String amount;
  final String percent;
  final Color bgColor;
  final Color borderColor;
  final Color valueColor;
  final bool arrowUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 14.height),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.radius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Row(
            children: [
              ImageItem(
               AppImages.occupancyIcon,
                color: valueColor,
               ),
              SizedBox(width: 12.width),
             
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w700,
                      color: valueColor,
                    ),
                  ),
              SizedBox(height: 4.height),

                   Text(
                percent,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: valueColor,
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
              color:AppThemeColors.of(context).textFieldTitle,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
