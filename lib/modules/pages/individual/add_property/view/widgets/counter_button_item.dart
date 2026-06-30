import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tc,
    this.iconColor,
    required this.enabled,
    this.isPrimery = false,
  });
  final bool isPrimery;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;
  final AppThemeColors tc;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isPrimery
              ? tc.primaryBrand
              : enabled
              ? tc.primaryBrand.withValues(alpha: 0.2)
              : tc.borderColor.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 18,
          color: isPrimery
              ? tc.onPrimary
              : enabled
              ? iconColor ?? tc.primaryBrand
              : tc.textSecondary,
        ),
      ),
    );
  }
}
