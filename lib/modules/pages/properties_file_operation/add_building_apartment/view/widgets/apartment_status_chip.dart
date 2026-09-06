import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ApartmentStatusChip extends StatelessWidget {
  const ApartmentStatusChip({
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
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.height),
          decoration: BoxDecoration(
            color: selected
                ? colors.primaryBrand.withValues(alpha: 0.12)
                : colors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? colors.primaryBrand : colors.borderColor,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? colors.primaryBrand : colors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
