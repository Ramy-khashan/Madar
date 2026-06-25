
import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge({super.key, required this.type, required this.colors});
  final String type;
  final AppThemeColors colors;

  static const _icons = {
    'buy': AppImages.activeIcon,
    'monthlyRent': AppImages.pendingIcon,
    'yearlyRent': AppImages.doneIcon,
  };

  @override
  Widget build(BuildContext context) {
    final label = switch (type) {
      'buy' => AppStrings.buyType,
      'monthlyRent' => AppStrings.monthlyRentType,
      'yearlyRent' => AppStrings.yearlyRentType,
      _ => type,
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageItem(_icons[type]!),
        SizedBox(width: 10.width),

        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
