import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_details_buyer_model.dart';

class PropertyDetailsInfoCardWidget extends StatelessWidget {
  const PropertyDetailsInfoCardWidget({super.key, required this.property});

  final PropertyBuyerModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.width, vertical: 8.height),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(16.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
           
              InfoRowWithIcon(label: AppStrings.bedrooms, value: property?.beds.toString() ?? '0', icon: AppImages.bedroomIcon),
              InfoRowWithIcon(label: AppStrings.balcony, value: property?.balconies.toString() ?? '0', icon: AppImages.balconyIcon),
              InfoRowWithIcon(label: AppStrings.bathrooms, value: property?.baths.toString() ?? '0', icon: AppImages.bathroomIcon),
              InfoRowWithIcon(label: AppStrings.area, value: property?.area ?? '0', icon: AppImages.totalSpaceIcon),
              InfoRowWithIcon(label: AppStrings.floor, value: property?.floor.toString() ?? '0', icon: AppImages.floorIcon),
              InfoRowWithIcon(label: AppStrings.propertyNumber, value: property?.propertyNumber ?? '', icon: AppImages.propertyNumberIcon),
              InfoRowWithIcon(label: AppStrings.paymentMethod, value: property?.paymentMethod ?? '', icon: AppImages.rentIcon, isLast: true),
            ],
          ),
        ),
      ],
    );
  }
}

class InfoRowWithIcon extends StatelessWidget {
  const InfoRowWithIcon({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.isLast = false,
  });

  final String label;
  final String value;
  final String icon;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageItem(icon, width: 18.width, height: 18.width, color: colors.primaryBrand),
                  SizedBox(width: 8.width),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      color: colors.textFieldTitle,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: colors.borderColor),
      ],
    );
  }
}
