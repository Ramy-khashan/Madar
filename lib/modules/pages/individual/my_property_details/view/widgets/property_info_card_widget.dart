import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_details_model.dart';

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
          PropertyInfoRowWidget(
            label: AppStrings.bedrooms,
            value: property?.beds.toString() ?? '0',
            icon: AppImages.bedroomIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.balcony,
            value: property?.balconies.toString() ?? '0',
            icon: AppImages.balconyIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.bathrooms,
            value: property?.baths.toString() ?? '0',
            icon: AppImages.bathroomIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.area,
            value: property?.area ?? '0',
            icon: AppImages.totalSpaceIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.floor,
            value: property?.floor.toString() ?? '0',
            icon: AppImages.floorIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.propertyNumber,
            value: property?.propertyNumber ?? '12',
            icon: AppImages.propertyNumberIcon,
          ),
          PropertyInfoRowWidget(
            label: AppStrings.paymentMethod,
            value: property?.paymentMethod ?? 'N/A',
            icon: AppImages.rentIcon,
          ),
        ],
      ),
    );
  }
}

class PropertyInfoRowWidget extends StatelessWidget {
  const PropertyInfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  final String label;
  final String value;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.height),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageItem(
                icon!,
                width: 20.width,
                height: 20.width,
                color: colors.primaryBrand,
              ),
              SizedBox(width: 8.width),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textSecondary,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w600,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
        ],
      ),
    );
  }
}
