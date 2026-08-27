import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/translation.dart';

class TypeBadge extends StatelessWidget {
  const TypeBadge({
    super.key,
    required this.type,
    required this.colors,
    this.label,
  });
  final String type;
  final String? label;
  final AppThemeColors colors;

  String get _normalized => type.toUpperCase();

  String get _icon {
    switch (_normalized) {
      case 'SALE':
      case 'BUY':
        return AppImages.activeIcon;
      case 'RENT':
      case 'MONTHLYRENT':
        return AppImages.pendingIcon;
      case 'YEARLYRENT':
        return AppImages.doneIcon;
      default:
        return AppImages.contractImage;
    }
  }

  String get _fallbackLabel {
    switch (_normalized) {
      case 'SALE':
      case 'BUY':
        return AppStrings.buyType;
      case 'RENT':
        return AppStrings.rentLabel;
      case 'MONTHLYRENT':
        return AppStrings.monthlyRentType;
      case 'YEARLYRENT':
        return AppStrings.yearlyRentType;
      default:
        return type.transIfExists;
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = (label ?? '').trim().isNotEmpty ? label! : _fallbackLabel;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageItem(_icon, width: 16.width, height: 16.width),
        SizedBox(width: 10.width),
        Text(
          text,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
