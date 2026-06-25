import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class PropertyTypeChipsWidget extends StatelessWidget {
  const PropertyTypeChipsWidget({
    super.key,
    required this.types,
    required this.selected,
    required this.onSelected,
  });

  final List<String> types;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: types.map((type) {
          final isSelected = type == selected;
          return GestureDetector(
            onTap: () => onSelected(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: EdgeInsets.only(left: 8.width),
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 8.height,
              ),
              decoration: BoxDecoration(
                color: isSelected ? colors.primaryBrand : colors.cardBackground,
                borderRadius: BorderRadius.circular(32.radius),
                border: Border.all(
                  color: isSelected ? colors.primaryBrand : colors.borderColor,
                ),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                  fontFamily: AppConstant.appFont,
                  color: isSelected ? colors.onPrimary : colors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
