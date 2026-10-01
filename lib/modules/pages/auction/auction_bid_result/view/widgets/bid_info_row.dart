import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class BidInfoRow extends StatelessWidget {
  const BidInfoRow({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontFamily: AppConstant.appFont,
            color: colors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
