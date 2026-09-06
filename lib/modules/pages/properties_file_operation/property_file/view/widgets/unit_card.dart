import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';
import 'property_info_item.dart';

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
    final statusColor = switch (unit.status) {
      UnitStatus.rented => AppColors.lightSuccessColor,
      UnitStatus.sold => AppColors.errorColor,
      UnitStatus.vacant => colors.textSecondary,
    };
    final statusLabel = switch (unit.status) {
      UnitStatus.rented => AppStrings.rentedStatus,
      UnitStatus.sold => AppStrings.soldStatus,
      UnitStatus.vacant => AppStrings.vacantStatus,
    };
    final unitId = unit.number.isNotEmpty ? unit.number : unit.label;
    final title = unitId.isEmpty
        ? AppStrings.apartmentType
        : '${AppStrings.apartmentType} $unitId';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(12.radius),
          border: Border.all(color: colors.borderColor),
        ),
        padding: EdgeInsets.all(8.width),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 26.width,
                  height: 26.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primaryBrand,
                    borderRadius: BorderRadius.circular(6.radius),
                  ),
                  child: Text(
                    unitId,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(11),
                      fontWeight: FontWeight.w700,
                      color: colors.onPrimary,
                      fontFamily: AppConstant.appHeaderFont,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.width,
                    vertical: 2.height,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.radius),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(9),
                      color: statusColor,
                      fontFamily: AppConstant.appFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.height),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w700,
                color: colors.textFieldTitle,
                fontFamily: AppConstant.appHeaderFont,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                if (unit.area > 0)
                  Expanded(
                    child: PropertyInfoItem(
                      icon: AppImages.totalSpaceIcon,
                      value: AppStrings.areaWithUnit(unit.area),
                      colors: colors,
                    ),
                  ),
                if (unit.rooms > 0)
                  Expanded(
                    child: PropertyInfoItem(
                      icon: AppImages.bedroomIcon,
                      value: AppStrings.roomsCount(unit.rooms),
                      colors: colors,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddApartmentCard extends StatelessWidget {
  const AddApartmentCard({
    super.key,
    required this.remaining,
    required this.colors,
    required this.onTap,
  });

  final int remaining;
  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(12.radius),
          border: Border.all(
            color: colors.primaryBrand.withValues(alpha: 0.45),
          ),
        ),
        padding: EdgeInsets.all(8.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32.width,
              height: 32.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.primaryBrand.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.radius),
              ),
              child: Icon(
                Icons.add_rounded,
                color: colors.primaryBrand,
                size: 22.width,
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              AppStrings.addApartment,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w700,
                color: colors.primaryBrand,
                fontFamily: AppConstant.appHeaderFont,
              ),
            ),
            SizedBox(height: 2.height),
            Text(
              AppStrings.remainingApartments(remaining),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(10),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
