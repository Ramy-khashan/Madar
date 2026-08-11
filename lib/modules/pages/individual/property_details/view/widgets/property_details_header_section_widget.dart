import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
 import '../../model/property_details_model.dart';

class PropertyDetailsHeaderSectionWidget extends StatelessWidget {
  const PropertyDetailsHeaderSectionWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final price = property?.price ?? 0;
    final formattedPrice =
        '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (m) => '${m[1]},')} ${AppStrings.currency}';

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property?.title ?? '',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(20),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),

              SizedBox(height: 6.height),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 16.width,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 4.width),
                    Row(
                      children: [
                        Text(
                          property?.location?.city ??
                              '${property?.location?.district != null ? ', ${property?.location?.district}' : ''}${property?.location?.street != null ? ', ${property?.location?.street}' : ''}',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                        SizedBox(width: 8.width),
                        ImageItem(AppImages.occupancyIcon, width: 16.width),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.width),
                          child: Text(
                            AppStrings.occupancyRate,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(13),
                              color: colors.primaryBrand,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ),
//TODO: Recheck occupancy rate value
                        Text(
                          // '${property?.occupancyRate ?? 0}%',
                          "",
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.primaryBrand,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          formattedPrice,
          style: TextStyle(
            fontSize: context.responsiveFontScale(18),
            fontWeight: FontWeight.w700,
            color: colors.primaryBrand,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
      ],
    );
  }
}
