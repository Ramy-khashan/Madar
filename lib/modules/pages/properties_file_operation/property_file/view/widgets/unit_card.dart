import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({
    super.key,
    required this.unit,
    required this.colors,
    this.onTap,
  });

  final UnitModel unit;
  final AppThemeColors colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isRented = unit.status == UnitStatus.rented;
    final statusColor = isRented
        ? AppColors.lightSuccessColor
        : colors.textFieldBorder;
    final statusLabel =
        isRented ? AppStrings.rentedStatus : AppStrings.vacantStatus;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16.radius),
          border: Border.all(color: colors.borderColor),
        ),
        padding: EdgeInsets.all(8.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.width,
                      vertical: 4.height,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryBrand,
                      borderRadius: BorderRadius.circular(4.radius),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      unit.number,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontWeight: FontWeight.w500,
                        color: colors.onPrimary,
                        fontFamily: AppConstant.appHeaderFont,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.width,
                    vertical: 2.height,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.radius),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(10),
                      color: statusColor,
                      fontFamily: AppConstant.appFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            // Label
            Text(
              unit.label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w500,
                color: colors.textFieldTitle,
                fontFamily: AppConstant.appHeaderFont,
              ),
            ),
            SizedBox(height: 4.height),
            // Stats row
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PropertyInfoItem(
                      icon: AppImages.bedroomIcon,
                      value: AppStrings.roomsCount(unit.rooms),
                      colors: colors,
                    ),
                  ),
                  SizedBox(width: 6.width),
                  Expanded(
                    child: PropertyInfoItem(
                      icon: AppImages.totalSpaceIcon,
                      value: AppStrings.areaWithUnit(unit.area),
                      colors: colors,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PropertyInfoItem extends StatelessWidget {
  const PropertyInfoItem({
    super.key,
    required this.icon,
    required this.value,
    required this.colors,
  });

  final String icon;
  final String value;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageItem(
          icon,
          color: colors.textSecondary,
          width: 12.width,
          height: 12.width,
        ),
        SizedBox(width: 2.width),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(9),
              color: colors.textFieldTitle,
              fontWeight: FontWeight.w500,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ),
      ],
    );
  }
}
