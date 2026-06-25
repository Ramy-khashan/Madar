import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class PropertyItem extends StatelessWidget {
  const PropertyItem({
    super.key,
    required this.label,
    required this.icon,
    required this.colors,
    this.isPrimary = false,
  });

  final bool isPrimary;

  final String label;
  final String icon;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 10.width,
          backgroundColor:  colors.hoverColor,
          child: ImageItem(
            icon,
            color: isPrimary ? colors.primaryBrand : null,
            width: 8.width,
            height: 8.height,
          ),
        ),
        SizedBox(width: 4.width),

        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(10),
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
