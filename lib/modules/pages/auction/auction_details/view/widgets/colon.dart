import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class Colon extends StatelessWidget {
  const Colon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: 14.height,
        left: 3.width,
        right: 3.width,
      ),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: context.responsiveFontScale(14),
          fontWeight: FontWeight.w700,
          color: colors.primaryBrand,
        ),
      ),
    );
  }
}
