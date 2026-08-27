import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyInfoItem extends StatelessWidget {
  const PropertyInfoItem({
    super.key,
    required this.icon,
    required this.value,
    required this.colors,
  });

  final String icon;
  final String value;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageItem(
          icon,
          color: colors.textSecondary,
          width: 12.width,
          height: 12.width,
        ),
        SizedBox(width: 2.width),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(9),
              color: colors.textFieldTitle,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ),
      ],
    );
  }
}
