import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ToggleBtn extends StatelessWidget {
  const ToggleBtn({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 28.width,
          vertical: 12.height,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.primaryBrand : AppColors.transparent,
          borderRadius: BorderRadius.circular(32.radius),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : colors.textFieldTitle,
              fontSize: context.responsiveFontScale(14),
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ),
      ),
    );
  }
}
