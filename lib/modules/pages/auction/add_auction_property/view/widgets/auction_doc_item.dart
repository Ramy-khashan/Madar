
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AuctionDocItem extends StatelessWidget {
  const AuctionDocItem({super.key, required this.colors});
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.height, bottom: 8.height),
          child: Text(
            AppStrings.photosLabel,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w500,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 130.height,
            decoration: BoxDecoration(
              color: colors.textFieldFill,
              borderRadius: BorderRadius.circular(12.radius),
              border: Border.all(
                  color: colors.textFieldBorder,
                  style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageItem(AppImages.uploadIcon),
                SizedBox(height: 8.height),
                Text(
                  AppStrings.clickToUpload,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  AppStrings.orDragHere,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontFamily: AppConstant.appFont,
                    color: colors.textSecondary,
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
