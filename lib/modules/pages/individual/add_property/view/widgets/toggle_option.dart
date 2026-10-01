import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ToggleOption extends StatelessWidget {
  const ToggleOption({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.tc,
  });
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          height: 44,
          decoration: BoxDecoration(
            color: isActive ? tc.primaryBrand : Colors.transparent,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              color: isActive ? tc.onPrimary : tc.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
