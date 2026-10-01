import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import 'toggle_btn.dart';

class FilterSaleToggle extends StatelessWidget {
  const FilterSaleToggle({
    super.key,
    required this.isForSale,
    required this.onChanged,
  });

  final bool isForSale;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8.width),
      decoration: BoxDecoration(
        color: colors.hoverColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(32.radius),
      ),
      child: Row(
        children: [
          Expanded(
            child: ToggleBtn(
              label: AppStrings.filterRent,
              selected: !isForSale,
              onTap: () => onChanged(false),
            ),
          ),
          SizedBox(width: 12.width),
          Expanded(
            child: ToggleBtn(
              label: AppStrings.filterForSale,
              selected: isForSale,
              onTap: () => onChanged(true),
            ),
          ),
        ],
      ),
    );
  }
}
