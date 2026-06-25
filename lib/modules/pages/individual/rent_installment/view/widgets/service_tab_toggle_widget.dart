import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ServiceTabToggleWidget extends StatelessWidget {
  const ServiceTabToggleWidget({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final void Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 12.height,
      ),
      child: Container(
        height: 48.height,
        decoration: BoxDecoration(
          color: colors.textSecondary.withValues(alpha: .15),
          borderRadius: BorderRadius.circular(32.radius),
          border: Border.all(color: colors.borderColor),
        ),
        child: Row(
          children: List.generate(
            labels.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                   decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? colors.primaryBrand
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(28.radius),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    labels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w600,
                      color: selectedIndex == index
                          ? colors.onPrimary
                          : colors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
