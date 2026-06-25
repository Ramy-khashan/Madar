
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';
class FeedbackRow extends StatelessWidget {
  const FeedbackRow({super.key, 
    required this.isFeedbackGiven,
    required this.isFeedbackPositive,
    required this.onFeedback,
  });

  final bool isFeedbackGiven;
  final bool isFeedbackPositive;
  final void Function(bool) onFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.height, bottom: 8.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FeedbackButton(
            icon: Icons.thumb_down_alt_outlined,
            isActive: isFeedbackGiven && !isFeedbackPositive,
            size: 38.width,
            iconSize: 20.fontSize,
            onTap: () => onFeedback(false),
          ),
          SizedBox(width: 10.width),
          FeedbackButton(
            icon: Icons.thumb_up_alt_outlined,
            isActive: isFeedbackGiven && isFeedbackPositive,
            size: 42.width,
            iconSize: 22.fontSize,
            onTap: () => onFeedback(true),
          ),
        ],
      ),
    );
  }
}

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({super.key, 
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
