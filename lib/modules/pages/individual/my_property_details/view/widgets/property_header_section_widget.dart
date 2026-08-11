import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../property_details/model/property_details_model.dart';
import '../../model/property_details_model.dart';

class PropertyHeaderSectionWidget extends StatelessWidget {
  const PropertyHeaderSectionWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                property?.title ?? 'Title',
                style: TextStyle(
                  fontSize: context.responsiveFontScale(20),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
            ),
            GestureDetector(
              key: Key('location_on_map_button'),
              onTap: () {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.propertyLocationMap,
                );
              },
              child: Text(
                AppStrings.locationOnMap,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  color: colors.primaryBrand,
                  decoration: TextDecoration.underline,
                  decorationColor: colors.primaryBrand,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.width,
                  color: colors.textSecondary,
                ),
                SizedBox(width: 4.width),
                Text(
                  '${property?.location?.city ?? ''}${property?.location?.district != null ? ', ${property?.location?.district}' : ''}${property?.location?.street != null ? ', ${property?.location?.street}' : ''}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const ImageItem(AppImages.occupancyIcon),
                SizedBox(width: 4.width),
                //TODO: Recheck occupancy rate value
                // Text(
                //   '${AppStrings.occupancyRate}: ${property?.occupancyRate.toInt() ?? 0}%',
                //   style: TextStyle(
                //     fontSize: context.responsiveFontScale(13),
                //     color: colors.textSecondary,
                //     fontFamily: AppConstant.appFont,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
