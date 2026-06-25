import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class FinancialMetricCard extends StatelessWidget {
  const FinancialMetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.valueColor,
    required this.colors,
    this.isStartedTextVal = false,
  });

  final String label;
  final String value;
  final String icon;
  final Color valueColor;
  final AppThemeColors colors;
  final bool isStartedTextVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(24.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.width),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primaryBrand.withValues(alpha: 0.18),
                ),
                child: ImageItem(
                  icon,
                  color: colors.primaryBrand,
                  width: 16.width,
                  height: 16.width,
                ),
              ),
              SizedBox(width: 8.width),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: colors.textFieldTitle,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstant.appHeaderFont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          Padding(
            padding: EdgeInsetsDirectional.only(start: isStartedTextVal ? 6.width : 0),
            child: Text(
              AppStrings.amountVal(value),
              textAlign: isStartedTextVal ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w700,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
