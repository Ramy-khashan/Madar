import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width),
      decoration: BoxDecoration(
        color: colors.backgroundPrimary,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              color: colors.textFieldHint,
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appFont,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colors.textFieldHint,
          ),
          dropdownColor: colors.backgroundPrimary,
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text(
                hint,
                style: TextStyle(
                  color: colors.textFieldHint,
                  fontSize: context.responsiveFontScale(14),
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ),
            ...items.map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                    color: colors.textFieldTitle,
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ),
            ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
