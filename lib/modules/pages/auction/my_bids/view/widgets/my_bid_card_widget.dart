import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/property_items.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/my_bid_item_model.dart';

class MyBidCardWidget extends StatelessWidget {
  const MyBidCardWidget({super.key, required this.item});
  final MyBidItemModel? item;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
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
                  height: 100.height,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(14.radius),
                ),
                SizedBox(width: 10.width),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item?.title ?? 'Title',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textFieldTitle,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 4.height),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.width,
                              vertical: 3.height,
                            ),
                            decoration: BoxDecoration(
                              color: MyBidItemModel.getBadgeColor(
                                item?.status ?? '',
                                colors,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12.radius),
                            ),
                            child: Text(
                              MyBidItemModel.getBadgeLabel(item?.status ?? ''),
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(11),
                                fontFamily: AppConstant.appFont,
                                fontWeight: FontWeight.w600,
                                color: MyBidItemModel.getBadgeTextColor(
                                  item?.status ?? '',
                                  colors,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.height),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 14.width,
                              color: colors.textSecondary,
                            ),
                            SizedBox(width: 4.width),
                            Expanded(
                              child: Text(
                                item?.location ?? 'Location',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(16),
                                  fontFamily: AppConstant.appFont,
                                  color: colors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            label:
                                '${item?.area.toInt() ?? 0} ${AppStrings.mesurement}',
                            icon: AppImages.totalSpaceIcon,
                            colors: colors,
                          ),
                        ],
                      ),
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
                    ],
                  ),
                ),
              ],
            ),
            AppButton(
              text: MyBidItemModel.getButtonText(item?.status ?? ''),
              isOutline: item?.status != 'ongoing',
              onTap: () {
                if (item?.status == 'ongoing') {
                  RouterHandler.navigate(
                    context,
                    AppRouterKeys.auctionDetails,
                    extra: item?.id,
                  );
                  return;
                } else {
                  AppToast('Action for status: ${item?.status}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
