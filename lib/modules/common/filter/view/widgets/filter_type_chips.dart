import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class FilterTypeChips extends StatelessWidget {
  const FilterTypeChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String? selected;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final types = [
      {'id': null, 'label': AppStrings.filterAllTypes},
      ...AppConstant.propertyTypes,
    ];
    return SizedBox(
      height: 30.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        separatorBuilder: (_, _) => SizedBox(width: 16.width),
        itemBuilder: (context, index) {
          final t = types[index];
          final id = t['id'];
          final label = t['label'] as String;
          final isSelected = id == selected;
          return GestureDetector(
            onTap: () => onChanged(id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 16.width),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.secondBrand
                    : colors.primaryBrand.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.radius),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : colors.textSecondary,
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
