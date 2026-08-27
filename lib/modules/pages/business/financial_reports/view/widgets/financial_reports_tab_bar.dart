import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class FinancialReportsTabBar extends StatelessWidget {
  const FinancialReportsTabBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.colors,
    required this.onTabChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final AppThemeColors colors;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
      decoration: BoxDecoration(
        color: colors.textFieldBorder.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(24.radius),
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final isSelected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(i),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.height),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primaryBrand
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(24.radius),
                ),
                child: Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected
                        ? colors.onPrimary
                        : colors.textFieldTitle,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
