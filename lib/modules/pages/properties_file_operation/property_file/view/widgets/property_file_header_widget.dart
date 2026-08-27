import 'package:flutter/material.dart';
import 'package:madar_app/core/utils/constants/storage_keys.dart';
import 'package:madar_app/core/utils/functions/preference_utils.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';
import 'property_status_card.dart';

class PropertyFileHeaderWidget extends StatelessWidget {
  const PropertyFileHeaderWidget({
    super.key,
    required this.property,
    required this.colors,
    required this.onBookmarkTap,
  });

  final PropertyFileModel? property;
  final AppThemeColors colors;
  final VoidCallback onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero image with overlay badges
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.radius),
              child: ImageItem(
                property?.imageUrl ?? '',
                width: double.infinity,
                height: 200.height,
                fit: BoxFit.cover,
              ),
            ),
            // Bookmark
            Positioned(
              top: 12.height,
              left: 12.width,
              child: GestureDetector(
                onTap: onBookmarkTap,
                child: Container(
                  padding: EdgeInsets.all(8.width),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    property?.isBookmarked ?? false
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: colors.primaryBrand,
                    size: 20.width,
                  ),
                ),
              ),
            ),
            // Property type tag
            Positioned(
              top: 12.height,
              right: 12.width,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.width,
                  vertical: 4.height,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryBrand,
                  borderRadius: BorderRadius.circular(20.radius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageItem(
                      AppImages.propertyShapeIcon,
                      width: 16.width,
                      height: 16.width,
                    ),
                    SizedBox(width: 4.width),
                    Text(
                      property?.propertyType ?? '',
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: context.responsiveFontScale(12),
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.height),
        // Name
        Text(
          property?.name ?? 'Property Name',
          style: TextStyle(
            fontSize: context.responsiveFontScale(20),
            fontWeight: FontWeight.w700,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
        SizedBox(height: 4.height),
        // Location
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_rounded,
              size: 16.width,
              color: colors.textSecondary,
            ),
            SizedBox(width: 4.width),

            Text(
              property?.location ?? 'Location not available',
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.height),
        // Stats row
        PreferenceUtils().getString(StorageKeys.accountType) ==
                AppConstant.business
            ? Row(
                children: [
                  Expanded(
                    child: PropertyStatusCard(
                      icon: Icons.home_outlined,
                      value: '${property?.totalUnits ?? 0}',
                      label: AppStrings.apartments,
                      colors: colors,
                    ),
                  ),

                  SizedBox(width: 8.width),
                  Expanded(
                    child: PropertyStatusCard(
                      icon: Icons.bar_chart,
                      value: '${property?.occupancyRate ?? 0}%',
                      label: AppStrings.occupancyRate,
                      colors: colors,
                    ),
                  ),
                  SizedBox(width: 8.width),
                  Expanded(
                    child: PropertyStatusCard(
                      icon: Icons.description_outlined,
                      value: '${property?.monthlyRevenue ?? 0}',
                      label: AppStrings.monthlyRevenue,
                      colors: colors,
                    ),
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.all(16.width),
                decoration: BoxDecoration(
                  color: colors.cardBackground,
                  borderRadius: BorderRadius.circular(20.radius),
                  border: Border.all(color: colors.borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.width),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.radius),
                        color: colors.primaryBrand.withValues(alpha: 0.3),
                      ),
                      child: ImageItem(
                        AppImages.apartmentIcon,
                        color: colors.primaryBrand,
                        width: 20.width,
                        height: 20.width,
                      ),
                    ),
                    SizedBox(width: 12.width),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${property?.totalUnits ?? 0}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            fontWeight: FontWeight.w700,
                            color: colors.textFieldTitle,
                            fontFamily: AppConstant.appHeaderFont,
                          ),
                        ),
                        SizedBox(height: 4.height),

                        Text(
                          AppStrings.apartmentsCount,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
