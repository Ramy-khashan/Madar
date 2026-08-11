import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
 import '../../../../../../../core/utils/functions/responsive.dart';

class CounterFieldWidget extends StatelessWidget {
  const CounterFieldWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;
  final int minValue;
  final int? maxValue;

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
          padding: EdgeInsets.symmetric(horizontal: 12.width),
          decoration: BoxDecoration(
                    color: tc.borderColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: tc.textFieldTitle.withValues(alpha: 0.3),
                    ),
                  ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             
             
              InkWell(
                onTap: () {
                  if (maxValue == null || value < maxValue!) {
                    onChanged(value + 1);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(6.width),
                  decoration: BoxDecoration(
                    color: tc.primaryBrand,
                  borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.add, size: 16, color: Colors.white),
                ),
              ),
               Text(
                '$value',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.bold,
                  color: tc.textPrimary,
                ),
              ),
               InkWell(
                onTap: () {
                  if (value > minValue) {
                    onChanged(value - 1);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(6.width),
                  decoration: BoxDecoration(
                    color: value > minValue ? tc.primaryBrand : const Color(0xFFCBD5E1),
                  borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.remove, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
 