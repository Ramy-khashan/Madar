import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

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
            child: _ToggleBtn(
              label: AppStrings.filterRent,
              selected: !isForSale,
              onTap: () => onChanged(false),
            ),
          ),
          SizedBox(width: 12.width),
          Expanded(
            child: _ToggleBtn(
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

class _ToggleBtn extends StatelessWidget {
  const _ToggleBtn({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 28.width,
          vertical: 12.height,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.primaryBrand : AppColors.transparent,
          borderRadius: BorderRadius.circular(32.radius),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : colors.textFieldTitle,
              fontSize: context.responsiveFontScale(14),
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ),
      ),
    );
  }
}
