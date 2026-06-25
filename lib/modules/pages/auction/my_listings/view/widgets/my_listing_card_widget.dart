import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/property_items.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/my_listing_item_model.dart';
import 'my_list_action_item.dart';

class MyListingCardWidget extends StatelessWidget {
  const MyListingCardWidget({super.key, required this.item});
  final MyListingItemModel? item;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.radius),
        border: Border.all(color: colors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageItem(
                  item?.imageUrl ?? '',
                  width: 100.width,
                  height: 110.height,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(12.radius),
                ),
                SizedBox(width: 10.width),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item?.title ?? 'Title not specified',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(15),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 6.height),

                          StatusBadge(
                            status: item?.status ?? 'unknown',
                            colors: colors,
                          ),
                        ],
                      ),
                      SizedBox(height: 4.height),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 14.width,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 4.width),
                          Expanded(
                            child: Text(
                              item?.location ?? 'Location not specified',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(12),
                                fontFamily: AppConstant.appFont,
                                color: colors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.height),
                      Row(
                        children: [
                          PropertyItem(
                            isPrimary: true,
                            label: '${item?.rooms ?? 0}',
                            icon: AppImages.bedroomIcon,
                            colors: colors,
                          ),
                          SizedBox(width: 10.width),
                          PropertyItem(
                            isPrimary: true,
                            label: '${item?.bathrooms ?? 0}',
                            icon: AppImages.bathroomIcon,
                            colors: colors,
                          ),
                          SizedBox(width: 10.width),
                          PropertyItem(
                            isPrimary: true,
                            label: '${item?.area.toInt() ?? 0} ${AppStrings.mesurement}',
                            icon: AppImages.totalSpaceIcon,
                            colors: colors,
                          ),
                        ],
                      ),
                      if (item?.startingBid != null && item?.startingBid != 0)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.height),
                          child: Text(
                            '${AppStrings.startingBidLabel}: ${formatPrice(item?.startingBid ?? 0)} ${AppStrings.currency}',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              fontFamily: AppConstant.appHeaderFont,
                              color: AppColors.secondBrand,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      if (item?.endTime != null)
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 14.width,
                              color: Colors.red,
                            ),
                            SizedBox(width: 4.width),
                            Text(
                              MyListingItemModel.getCountDownString(
                                item?.endTime,
                              ),
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                fontFamily: AppConstant.appFont,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.height),
            BodyContent(item: item, colors: colors),
          ],
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, required this.colors});
  final String status;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final colorAndLabel = MyListingItemModel.getColorAndLabel(
      colors: colors,
      status: status,
    );
    final bgColor = colorAndLabel['bgColor'] as Color;
    final textColor = colorAndLabel['textColor'] as Color;
    final label = colorAndLabel['label'] as String;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 3.height),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == 'active')
            Padding(
              padding: EdgeInsets.only(left: 4.width),
              child: Icon(Icons.circle, size: 7.width, color: textColor),
            ),
          if (status == 'completed')
            Padding(
              padding: EdgeInsets.only(left: 4.width),
              child: Icon(
                Icons.check_circle_outline,
                size: 12.width,
                color: textColor,
              ),
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(11),
              fontFamily: AppConstant.appFont,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
