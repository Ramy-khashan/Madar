import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import 'apartment_calendar_option.dart';

class ApartmentCalendarToggle extends StatelessWidget {
  const ApartmentCalendarToggle({
    super.key,
    required this.isHijri,
    required this.onChanged,
  });

  final bool isHijri;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.borderColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          ApartmentCalendarOption(
            label: AppStrings.gregorian,
            active: !isHijri,
            onTap: () => onChanged(false),
          ),
          ApartmentCalendarOption(
            label: AppStrings.hijri,
            active: isHijri,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}
