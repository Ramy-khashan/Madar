import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/rent_options_model.dart';

class PlanTileItem extends StatelessWidget {
  const PlanTileItem({
    required this.plan,
    required this.isSelected,
    required this.isLast,
    required this.onTap,
    super.key,
  });

  final InstallmentPlanModel plan;
  final bool isSelected;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.height),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 14.height,
              ),
              decoration: BoxDecoration(
           
                borderRadius: BorderRadius.circular(16.radius),
                border: Border.all(color:isSelected ? colors.primaryBrand : colors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${plan.monthsCount} ${AppStrings.installmentsSuffix}',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w500,
                      color: colors.textFieldTitle.withValues(alpha: .9),
                      fontFamily: AppConstant.appHeaderFont,
                    ),
                  ),
                  SizedBox(height: 8.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '+ ${plan.fees.toInt()} ${AppStrings.feesSuffix}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),

                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: plan.monthlyAmount.toInt().toString(),
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontWeight: FontWeight.w500,
                                color: colors.primaryBrand,
                                fontFamily: AppConstant.appHeaderFont,
                              ),
                            ),

                            TextSpan(
                              text: ' ${AppStrings.monthlyAmountSuffix}',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.primaryBrand,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
