
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class CompleteAuctionInfoCellItem extends StatelessWidget {
  const CompleteAuctionInfoCellItem({super.key, 
    required this.label,
    required this.value,
    required this.colors,
    required this.icon,

  });
  final String label;
  final String value;
  final AppThemeColors colors;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageItem(icon, ),
            SizedBox(width: 3.width),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontFamily: AppConstant.appFont,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.height),
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w700,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
      ],
    );
  }
}
