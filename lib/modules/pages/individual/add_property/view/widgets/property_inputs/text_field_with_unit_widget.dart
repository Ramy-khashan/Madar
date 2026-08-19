import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class TextFieldWithUnitWidget extends StatelessWidget {
  const TextFieldWithUnitWidget({
    super.key,
    required this.label,
    this.controller,
    this.placeholder,
    this.suffixText,
    this.onChanged,
  });

  final String label;
  final TextEditingController? controller;
  final String? placeholder;
  final String? suffixText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w600,
            color: tc.textFieldTitle,
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
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: TextStyle(
                      color: const Color(0xFF94A3B8),
                      fontSize: context.responsiveFontScale(14),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(
                    color: tc.textPrimary,
                    fontSize: context.responsiveFontScale(14),
                  ),
                ),
              ),
              if (suffixText != null)
                Padding(
                  padding: EdgeInsets.only(left: 8.width),
                  child: Text(
                    suffixText!,
                    style: TextStyle(
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.bold,
                      fontSize: context.responsiveFontScale(12),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
