import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class TimeBox extends StatelessWidget {
  const TimeBox({super.key, required this.value, required this.label});
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.width,
            vertical: 4.height,
          ),

          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: context.responsiveFontScale(12),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w700,
              color: colors.primaryBrand,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(10),
            fontFamily: AppConstant.appFont,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
