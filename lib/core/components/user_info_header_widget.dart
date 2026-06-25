import 'package:flutter/material.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class UserInfoHeaderWidget extends StatelessWidget {
  const UserInfoHeaderWidget({
    super.key,
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.propertiesCount,
    this.imageUrl,
    this.isBroker = false,
  });

  final String name;
  final double rating;
  final int reviewsCount;
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
          _Avatar(isBroker: isBroker, imageUrl: imageUrl, colors: colors),
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
                    Icon(Icons.star, size: 14.width, color: AppColors.rate),
                    SizedBox(width: 3.width),
                    Text(
                      '$rating',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.textFieldTitle,
                      ),
                    ),
                    Text(
                      ' ($reviewsCount)',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        fontFamily: AppConstant.appHeaderFont,
                        color: colors.textSecondary,
                      ),
                    ),
                    Text(
                      '  •  ',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: colors.textSecondary,
                      ),
                    ),
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.isBroker, this.imageUrl, required this.colors});

  final bool isBroker;
  final String? imageUrl;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final image = ImageItem(
      imageUrl ?? AppImages.agentImage,
      fit: BoxFit.cover,
      width: isBroker ? 48.width : 46.width,
      height: isBroker ? 48.width : 46.width,
    );

    if (isBroker) {
      return Container(
        width: 52.width,
        height: 52.width,
        decoration: BoxDecoration(
          color: colors.primaryBrand.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.radius),
        ),
        child: image,
      );
    }

    return Container(
      width: 52.width,
      height: 52.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primaryBrand.withValues(alpha: 0.1),
      ),
      child: ClipOval(child: image),
    );
  }
}
