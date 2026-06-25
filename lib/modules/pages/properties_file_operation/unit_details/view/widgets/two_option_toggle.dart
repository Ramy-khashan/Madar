import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

/// Two-option toggle (e.g. مؤجرة / شاغرة or هجري / ميلادي)
class TwoOptionToggle extends StatelessWidget {
  const TwoOptionToggle({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.isRightSelected,
    required this.colors,
    required this.onChanged,
  });

  final String leftLabel;
  final String rightLabel;
  final bool isRightSelected;
  final AppThemeColors colors;
  final ValueChanged<bool> onChanged; // true = right selected

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ToggleOption(
            label: leftLabel,
            isSelected: !isRightSelected,
            colors: colors,
            onTap: () => onChanged(false),
          ),
        ),
        SizedBox(width: 8.width),
        Expanded(
          child: _ToggleOption(
            label: rightLabel,
            isSelected: isRightSelected,
            colors: colors,
            onTap: () => onChanged(true),
          ),
        ),
      ],
    );
  }
}

class _ToggleOption extends StatelessWidget {
  const _ToggleOption({
    required this.label,
    required this.isSelected,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.height),
        decoration: BoxDecoration(
          color: isSelected ? colors.primaryBrand : colors.hoverColor,
          borderRadius: BorderRadius.circular(30.radius),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appFont,
            color: isSelected ? colors.onPrimary : colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
