import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class LicenseRow extends StatelessWidget {
  const LicenseRow({super.key, required this.colors, required this.text});

  final AppThemeColors colors;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13.height, horizontal: 8.width),
      decoration: BoxDecoration(
        color: colors.primaryBrand.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          ImageItem(AppImages.safetyIcon, width: 16.width),
          SizedBox(width: 8.width),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colors.primaryBrand,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
