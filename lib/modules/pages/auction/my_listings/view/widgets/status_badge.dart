import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/my_listing_item_model.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, required this.colors});
  final String status;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final colorAndLabel = MyListingItemModel.getColorAndLabel(
      colors: colors,
      status: status,
    );
    final bgColor = colorAndLabel['bgColor'] as Color;
    final textColor = colorAndLabel['textColor'] as Color;
    final label = colorAndLabel['label'] as String;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 3.height),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == 'active')
            Padding(
              padding: EdgeInsets.only(left: 4.width),
              child: Icon(Icons.circle, size: 7.width, color: textColor),
            ),
          if (status == 'completed')
            Padding(
              padding: EdgeInsets.only(left: 4.width),
              child: Icon(
                Icons.check_circle_outline,
                size: 12.width,
                color: textColor,
              ),
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(11),
              fontFamily: AppConstant.appFont,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
