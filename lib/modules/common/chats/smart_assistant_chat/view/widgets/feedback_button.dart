import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({
    super.key,
    required this.icon,
    required this.isActive,
    required this.size,
    required this.iconSize,
    required this.onTap,
  });

  final IconData icon;
  final bool isActive;
  final double size;
  final double iconSize;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isActive
              ? AppThemeColors.of(context).primaryBrand
              : AppThemeColors.of(context).backgroundSecondary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isActive
              ? AppThemeColors.of(context).textPrimary
              : AppThemeColors.of(context).textSecondary,
          size: iconSize,
        ),
      ),
    );
  }
}
