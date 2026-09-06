import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class BuildingStatusPill extends StatelessWidget {
  const BuildingStatusPill({
    super.key,
    required this.label,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10.height),
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryBrand
              : colors.borderColor.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(22.radius),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: context.responsiveFontScale(13),
            color: selected ? colors.onPrimary : colors.textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
      ),
    );
  }
}
