import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PropertyInfoRowWidget extends StatelessWidget {
  const PropertyInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if ((icon ?? '').isNotEmpty)
                ImageItem(
                  icon!,
                  width: 20.width,
                  height: 20.width,
                  color: colors.primaryBrand,
                ),
              if ((icon ?? '').isNotEmpty) SizedBox(width: 8.width),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w600,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ],
      ),
    );
  }
}
