import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class OwnerFinancialStatTile extends StatelessWidget {
  const OwnerFinancialStatTile({
    super.key,
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.radius),
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(12),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
            ),
          ),
          SizedBox(height: 4.height),
          Text(
            '${formatPrice(amount)} ${AppStrings.currency}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(11),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
