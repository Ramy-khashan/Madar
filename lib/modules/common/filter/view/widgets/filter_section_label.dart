import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class FilterSectionLabel extends StatelessWidget {
  const FilterSectionLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: context.responsiveFontScale(15),
        fontWeight: FontWeight.w600,
        fontFamily: AppConstant.appHeaderFont,
        color: colors.textFieldTitle,
      ),
    );
  }
}
