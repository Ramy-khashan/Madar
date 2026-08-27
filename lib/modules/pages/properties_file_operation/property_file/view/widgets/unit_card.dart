import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/translation.dart';
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
      UnitStatus.vacant => colors.textFieldBorder,
    };
    final statusLabel = unit.rawStatus.isNotEmpty
        ? unit.rawStatus.transIfExists
        : switch (unit.status) {
            UnitStatus.rented => AppStrings.rentedStatus,
            UnitStatus.sold => AppStrings.soldStatus,
            UnitStatus.vacant => AppStrings.vacantStatus,
          };

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
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
            const Spacer(),
            Text(
              unit.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w500,
                color: colors.textFieldTitle,
                fontFamily: AppConstant.appHeaderFont,
              ),
            ),
            SizedBox(height: 4.height),
            if (unit.monthlyRent > 0)
              Text(
                '${formatPrice(unit.monthlyRent)} ${AppStrings.currency}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(11),
                  fontWeight: FontWeight.w700,
                  color: colors.primaryBrand,
                  fontFamily: AppConstant.appHeaderFont,
                ),
              ),
            if (unit.rooms > 0 || unit.area > 0) ...[
              SizedBox(height: 4.height),
              Row(
                children: [
                  if (unit.rooms > 0)
                    Expanded(
                      child: PropertyInfoItem(
                        icon: AppImages.bedroomIcon,
                        value: AppStrings.roomsCount(unit.rooms),
                        colors: colors,
                      ),
                    ),
                  if (unit.area > 0)
                    Expanded(
                      child: PropertyInfoItem(
                        icon: AppImages.totalSpaceIcon,
                        value: AppStrings.areaWithUnit(unit.area),
                        colors: colors,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

