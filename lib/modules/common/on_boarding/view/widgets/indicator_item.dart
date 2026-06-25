import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/utils/functions/responsive.dart';

class IndicatorItem extends StatelessWidget {
  const IndicatorItem({super.key, required this.selectedIndex});
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          3,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: (index == selectedIndex ? 32 : 8).width,
            height: 8.width,
            margin: EdgeInsets.symmetric(horizontal: 3.width),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.width),
              color: index == selectedIndex
                  ? AppThemeColors.of(context).primaryBrand
                  : AppThemeColors.of(
                      context,
                    ).primaryBrand.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),
    );
  }
}
