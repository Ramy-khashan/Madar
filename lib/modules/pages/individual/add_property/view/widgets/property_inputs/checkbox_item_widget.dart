import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class CheckboxItemWidget extends StatelessWidget {
  const CheckboxItemWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
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
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank_rounded,
                  color: isSelected ? tc.primaryBrand : const Color(0xFFCBD5E1),
                ),
                SizedBox(width: 8.width),

                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,

                    fontSize: 14.fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
