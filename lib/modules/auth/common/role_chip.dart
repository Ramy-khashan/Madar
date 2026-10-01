import 'package:flutter/material.dart';
import '../../../config/theme/app_theme_colors.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/functions/responsive.dart';

class RoleChip extends StatelessWidget {
  const RoleChip({
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
        padding: EdgeInsets.symmetric(vertical: 12.height),
        decoration: BoxDecoration(
          color: selected ? colors.primaryBrand : AppColors.transparent,
          borderRadius: BorderRadius.circular(32.radius),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontWeight: FontWeight.w600,
              color: selected ? colors.onPrimary : colors.textSecondary,
              fontFamily: AppConstant.appHeaderFont,
            ),
          ),
        ),
      ),
    );
  }
}
