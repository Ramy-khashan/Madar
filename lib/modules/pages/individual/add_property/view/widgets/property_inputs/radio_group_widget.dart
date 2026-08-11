import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class RadioGroupWidget extends StatelessWidget {
  const RadioGroupWidget({
    super.key,
    required this.label,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  final String label;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w600,
              color: tc.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),
        ],
        Row(
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(option),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.width),
                  height: 50,
                  decoration: BoxDecoration(
                    color: tc.borderColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: tc.textFieldTitle.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 16.width),
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: isSelected
                            ? tc.primaryBrand
                            : const Color(0xFFCBD5E1),
                      ),
                      SizedBox(width: 8.width),

                      Text(
                        option,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
