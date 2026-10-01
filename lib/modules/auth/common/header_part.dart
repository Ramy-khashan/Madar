import 'package:flutter/material.dart';

import '../../../config/theme/app_theme_colors.dart';
import '../../../core/components/image_item.dart';
import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/constants/app_images.dart';
import '../../../core/utils/functions/responsive.dart';

class HeaderPart extends StatelessWidget {
  const HeaderPart({super.key, required this.isTable, this.height = 350});
  final bool isTable;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isTable ? 2 : 0,

      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 16.height,
                bottom: 8.height,
              ),
              child: ImageItem(
                AppImages.splashLogo,
                height: 58.height,
                width: 74.width,
                color: AppThemeColors.of(context).primaryBrand,
              ),
            ),
            Text(
              AppConstant.splashName,
              style: TextStyle(
                fontSize: context.responsiveFontScale(36),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appFont,
                height: 1,
                color: AppThemeColors.of(context).primaryBrand,
              ),
            ),
            Text(
              AppConstant.splashEnName,
              style: TextStyle(
                fontSize: context.responsiveFontScale(15),
                fontWeight: FontWeight.w500,
                letterSpacing: 8,
                fontFamily: AppConstant.appHeaderFont,
                color: AppThemeColors.of(context).primaryBrand,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
