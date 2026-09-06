import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ApartmentCalendarOption extends StatelessWidget {
  const ApartmentCalendarOption({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
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
          height: 38,
          decoration: BoxDecoration(
            color: active ? colors.primaryBrand : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: context.responsiveFontScale(13),
              color: active ? colors.onPrimary : colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
