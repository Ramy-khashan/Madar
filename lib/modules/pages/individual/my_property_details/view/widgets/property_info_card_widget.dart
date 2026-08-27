import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_details/model/property_details_model.dart';
import 'property_info_row_widget.dart';

class PropertyInfoCardWidget extends StatelessWidget {
  const PropertyInfoCardWidget({super.key, required this.property});

  final PropertyDetailsModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.height),
            child: Text(
              AppStrings.propertyDetailsTitle,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
          ),
          // PropertyInfoRowWidget(
          //   label: AppStrings.bedrooms,
          //   value: property?.details?.beds.toString() ?? '0',
          //   icon: AppImages.bedroomIcon,
          // ),
          // PropertyInfoRowWidget(
          //   label: AppStrings.balcony,
          //   value: property?.details.balconies.toString() ?? '0',
          //   icon: AppImages.balconyIcon,
          // ),
          // PropertyInfoRowWidget(
          //   label: AppStrings.bathrooms,
          //   value: property?.details.baths.toString() ?? '0',
          //   icon: AppImages.bathroomIcon,
          // ),
          PropertyInfoRowWidget(
            label: AppStrings.area,
            value:( property?.totalArea ?? '0').toString(),
            icon: AppImages.totalSpaceIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.floor,
            value: property?.details?.floor.toString() ?? '0',
            icon: AppImages.floorIcon,
          ),
          // PropertyInfoRowWidget(
          //   label: AppStrings.propertyNumber,
          //   value: property?.details.propertyNumber ?? '12',
          //   icon: AppImages.propertyNumberIcon,
          // ),
          PropertyInfoRowWidget(
            label: AppStrings.paymentMethod,
            value: property?.paymentType ?? 'N/A',
            icon: AppImages.rentIcon,
          ),
        ],
      ),
    );
  }
}
