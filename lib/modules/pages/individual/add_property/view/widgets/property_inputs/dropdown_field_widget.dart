import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/translation.dart';

class DropdownFieldWidget extends StatelessWidget {
  const DropdownFieldWidget({
    super.key,
    required this.label,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hint,
    this.translateItems = true,
    this.errorText,
  });

  final String label;

  /// API wire values; the visible text comes from translating each entry.
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String? hint;
  final bool translateItems;
  final String? errorText;

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
            border: Border.all(
              color: errorText != null
                  ? const Color(0xFFB00020)
                  : tc.textFieldBorder,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(selectedValue) ? selectedValue : null,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: tc.primaryBrand),
              hint: hint == null
                  ? null
                  : Text(
                      hint!,
                      style: TextStyle(
                        color: tc.textFieldHint,
                        fontSize: context.responsiveFontScale(14),
                      ),
                    ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    translateItems ? item.trans : item,
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
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsetsDirectional.only(top: 6.height, start: 8.width),
            child: Text(
              errorText!,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                color: const Color(0xFFB00020),
              ),
            ),
          ),
      ],
    );
  }
}
