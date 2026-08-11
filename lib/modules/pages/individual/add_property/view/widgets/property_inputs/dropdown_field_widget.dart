import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class DropdownFieldWidget extends StatelessWidget {
  const DropdownFieldWidget({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  final String label;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0, top: 12.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.fontSize,
              fontWeight: FontWeight.w600,
              color: tc.textFieldTitle,
            ),
          ),
        ),
        SizedBox(height: 8.height),
        Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 16.width),
          decoration: BoxDecoration(
            color: tc.textFieldFill,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: tc.textFieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: tc.primaryBrand),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      color: tc.textPrimary,
                      fontSize: context.responsiveFontScale(14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
