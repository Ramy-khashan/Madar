import 'package:flutter/material.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'avatar.dart';

class UserInfoHeaderWidget extends StatelessWidget {
  const UserInfoHeaderWidget({
    super.key,
    required this.name,
    required this.propertiesCount,
    this.imageUrl,
    this.isBroker = false,
  });

  final String name;

  final int propertiesCount;

  final String? imageUrl;

  final bool isBroker;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 10.height,
      ),
      child: Row(
        children: [
          Avatar(isBroker: isBroker, imageUrl: imageUrl, colors: colors),
          SizedBox(width: 10.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.height),
                Row(
                  children: [
                    Text(
                      '$propertiesCount ${AppStrings.propertiesCountLabel}',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 8.width),
          ImageItem(AppImages.safetyIcon, width: 20.width, height: 20.width),
        ],
      ),
    );
  }
}
