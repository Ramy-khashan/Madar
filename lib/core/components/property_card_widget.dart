import 'package:flutter/material.dart';
import 'package:madar_app/core/utils/functions/translation.dart';

import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/individual_home/model/properties_item_model.dart';
import 'image_item.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import '../../config/router/app_router_keys.dart';
import '../utils/functions/common_fun.dart';
import 'property_items.dart';

class PropertyCardWidget extends StatelessWidget {
  const PropertyCardWidget({
    super.key,
    required this.property,
    this.footer,
    this.onBack,
    this.isWithWidth = false,
    this.isViewAll = false,
  });
  final bool isWithWidth;
  final void Function()? onBack;
  final bool isViewAll;
  final Widget? footer;
  final PropertiesItemModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return GestureDetector(
      onTap: () {
        RouterHandler.navigate(
          context,
          AppRouterKeys.propertyDetails,
          extra: property?.propertyId,
        ).then((value) {
          if (onBack != null) {
            onBack!();
          }
        });
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: isWithWidth
            ? context.screenWidth * (context.isTablet ? 0.4 : 0.85)
            : null,
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(32.radius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.width),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.radius),
                    child: ImageItem(
                      property?.image ?? '',
                      fit: BoxFit.cover,
                      height: 124.height,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(8.radius),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.width),
              child: property?.type != null && property!.type!.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.width,
                        vertical: 6.height,
                      ),
                      decoration: BoxDecoration(
                        color: AppThemeColors.of(
                          context,
                        ).primaryBrand.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.radius),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ImageItem(AppImages.propertyShapeIcon),
                          SizedBox(width: 4.width),
                          Text(
                            (property!.type ?? '').trans,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(12),
                              color: AppThemeColors.of(context).primaryBrand,
                              fontFamily: AppConstant.appHeaderFont,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: EdgeInsets.all(8.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    property?.title ?? 'Project Name',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstant.appHeaderFont,
                      color: colors.primaryBrand,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.height),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.width,
                        color: colors.textFieldTitle.withValues(alpha: 0.7),
                      ),
                      SizedBox(width: 4.width),
                      Expanded(
                        child: Text(
                          property != null
                              ? ('${property?.city ?? " "} - ${property?.district ?? ""}')
                              : 'Property Location',
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            fontFamily: AppConstant.appHeaderFont,
                            fontWeight: FontWeight.w500,
                            color: colors.textFieldTitle.withValues(alpha: 0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isViewAll)
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${formatPrice(double.parse(property?.price.toString() ?? '0'))} ',
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(20),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: AppConstant.appHeaderFont,
                                    color: colors.textFieldTitle.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: AppStrings.currency,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    fontFamily: AppConstant.appHeaderFont,
                                    color: colors.textFieldTitle.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Divider(
                    height: 20.height,
                    thickness: 1,
                    color: colors.textSecondary.withValues(alpha: 0.3),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PropertyItem(
                        label:
                            '${property?.totalArea ?? '0'} ${AppStrings.mesurement}',
                        icon: AppImages.totalSpaceIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),

                      PropertyItem(
                        label:
                            '${property?.bathrooms ?? 0} ${AppStrings.baths}',
                        icon: AppImages.bathroomIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),

                      PropertyItem(
                        label: '${property?.bedrooms ?? 0} ${AppStrings.beds}',
                        icon: AppImages.bedroomIcon,
                        colors: colors,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.height),
                  if (!isViewAll)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  '${formatPrice(double.parse((property?.price ?? '0').toString()))} ',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(20),
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textFieldTitle.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                            TextSpan(
                              text: AppStrings.currency,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textFieldTitle.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (footer != null) footer!,
                  SizedBox(height: 10.height),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
