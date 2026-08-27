import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    required this.tc,
  });
  final String icon;
  final String label;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: isSelected
              ? tc.primaryBrand.withValues(alpha: 0.08)
              : tc.cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? tc.primaryBrand : tc.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: tc.primaryBrand.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ImageItem(icon, width: 20, color: tc.primaryBrand),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: tc.borderColor),
                  ),
                  child: Icon(
                    isSelected ? Icons.check_rounded : Icons.add_rounded,
                    size: 16,
                    color: isSelected ? tc.primaryBrand : tc.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.height),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w700,
                color: isSelected ? tc.primaryBrand : tc.textPrimary,
              ),
            ),
            SizedBox(height: 2.height),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: context.responsiveFontScale(10),
                color: tc.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
