import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class FileUploadWidget extends StatelessWidget {
  const FileUploadWidget({super.key, this.title, this.onTap});

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Padding(
            padding: EdgeInsets.only(top: 14.height, bottom: 8.height),
            child: Text(
              title!,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w500,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
          ),
        ],
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 24.height,
              horizontal: 16.width,
            ),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(16.radius),
              border: Border.all(
                color: colors.borderColor,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                const ImageItem(AppImages.uploadIcon),
                SizedBox(height: 8.height),
                Text(
                  AppStrings.clickToUpload,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: colors.primaryBrand,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
                SizedBox(height: 12.height),
                Text(
                  AppStrings.orDragImagesHere,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
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
