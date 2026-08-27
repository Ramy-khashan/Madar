import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyInfo extends StatelessWidget {
  const PropertyInfo({
    super.key,
    required this.info,
    required this.icon,
    required this.colors,
  });
  final String info;
  final String icon;
  final AppThemeColors colors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.height),
      child: Row(
        children: [
          ImageItem(icon, width: 16.width, color: colors.primaryBrand),
          SizedBox(width: 6.width),
          Text(
            info,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w800,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
