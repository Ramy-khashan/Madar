import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../model/real_estate_news_item_model.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({super.key, required this.item});

  final RealEstateNewsItemModel? item;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(22.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ImageItem(
                item?.image ?? '',
                width: double.infinity,
                height: 180.height,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(18.radius),
              ),
              PositionedDirectional(
                top: 10.height,
                end: 10.width,
                child: Wrap(
                  spacing: 6.width,
                  children: (item?.tags ?? [])
                      .asMap()
                      .entries
                      .map(
                        (tag) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.width,
                            vertical: 4.height,
                          ),
                          decoration: BoxDecoration(
                            color: colors.primaryBrand,
                            borderRadius: BorderRadius.circular(20.radius),
                          ),
                          child: Text(
                            tag.value,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(12),
                              color: colors.onPrimary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item?.title ?? 'News Title',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
                SizedBox(height: 8.height),
                Text(
                  item?.body ?? 'News Content',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
                SizedBox(height: 10.height),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 15.width,
                      color: colors.textSecondary,
                    ),
                    SizedBox(width: 4.width),
                    Text(
                      '${item?.readMinutes ?? "0"} ${AppStrings.minutesLabel}',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        color: colors.textSecondary,
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      item?.timeAgo ?? '10 mins ago',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        color: colors.textSecondary,
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 8),

            child: AppButton(
              onTap: () => RouterHandler.navigate(
                context,
                AppRouterKeys.realEstateNewsDetails,
                extra: item?.id,
              ),
              text: AppStrings.readNewsBtn,
            ),
          ),
        ],
      ),
    );
  }
}
