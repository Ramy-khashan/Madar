
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AuctionDateTimeItem extends StatelessWidget {
  const AuctionDateTimeItem({super.key, 
    required this.title,
    required this.value,
    required this.icon,
    required this.colors,
    required this.onTap,
  });
  final String title;
  final String value;
  final IconData icon;
  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w500,
            fontFamily: AppConstant.appFont,
            color: colors.textFieldTitle,
          ),
        ),
        SizedBox(height: 6.height),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.width,
              vertical: 12.height,
            ),
            decoration: BoxDecoration(
              color: colors.textFieldFill,
              borderRadius: BorderRadius.circular(12.radius),
              border: Border.all(color: colors.textFieldBorder),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16.width, color: colors.textSecondary),
                SizedBox(width: 8.width),
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      fontFamily: AppConstant.appFont,
                      color: colors.textPrimary,
                    ),
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
