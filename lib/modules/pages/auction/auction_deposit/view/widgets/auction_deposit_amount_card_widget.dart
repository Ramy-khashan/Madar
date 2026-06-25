import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AuctionDepositAmountCardWidget extends StatelessWidget {
  const AuctionDepositAmountCardWidget({
    super.key,
    required this.depositAmount,
  });

  final double depositAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: AppColors.rate.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(
          color: AppColors.rate.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                AppStrings.depositAmountLabel,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w700,
                  color: AppThemeColors.of(context).textFieldTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.depositRequiredAmount,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontFamily: AppConstant.appFont,
                    color: AppThemeColors.of(context).textFieldTitle,
                  ),
                ),
              ),
              Text(
                '${formatPrice(depositAmount)} ${AppStrings.currency}',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(20),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.rate
                      : AppColors.brownColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          Container(
            padding: EdgeInsets.all(8.height),
            decoration: BoxDecoration(
              color: AppThemeColors.of(context).textFieldFill,
              borderRadius: BorderRadius.circular(8.radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.depositRefundPolicy,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appHeaderFont,
                    fontWeight: FontWeight.w700,
                    color: AppThemeColors.of(context).textFieldTitle,
                  ),
                ),
                SizedBox(height: 12.height),
                SelectableText(
                  AppStrings.depositRefundBullet1,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appFont,
                    color: AppThemeColors.of(context).textFieldTitle,
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    AppStrings.depositRefundBullet2,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontFamily: AppConstant.appFont,
                      color: AppThemeColors.of(context).textFieldTitle,
                      height: 1.5,
                    ),
                  ),
                ),
                Text(
                  AppStrings.depositRefundBullet3,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appFont,
                    color: AppThemeColors.of(context).textFieldTitle,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
