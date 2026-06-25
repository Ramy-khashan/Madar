import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';

class UnitsFilterTabBar extends StatelessWidget {
  const UnitsFilterTabBar({
    super.key,
    required this.colors,
    required this.selected,
    required this.rentedCount,
    required this.vacantCount,
    required this.onFilterChanged,
  });

  final AppThemeColors colors;
  final UnitStatus? selected;
  final int rentedCount;
  final int vacantCount;
  final ValueChanged<UnitStatus?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _FilterChip(
          label: 'شاغرة',
          count: vacantCount,
          isSelected: selected == UnitStatus.vacant,
          selectedColor: colors.primaryBrand,
          colors: colors,
          onTap: () => onFilterChanged(
            selected == UnitStatus.vacant ? null : UnitStatus.vacant,
          ),
        ),
        SizedBox(width: 8.width),
        _FilterChip(
          label: 'مؤجرة',
          count: rentedCount,
          isSelected: selected == UnitStatus.rented,
          selectedColor: colors.primaryBrand,
          colors: colors,
          onTap: () => onFilterChanged(
            selected == UnitStatus.rented ? null : UnitStatus.rented,
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.selectedColor,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final Color selectedColor;
  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 6.height),
        decoration: BoxDecoration(
          color:
              isSelected ? selectedColor : colors.hoverColor,
          borderRadius: BorderRadius.circular(20.radius),
        ),
        child: Text(
          '$label $count',
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appFont,
            color: isSelected ? colors.onPrimary : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
