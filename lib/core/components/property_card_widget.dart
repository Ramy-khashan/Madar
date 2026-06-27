import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/individual_home/model/property_model.dart';
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
    this.isWithWidth = false,
    this.isViewAll = false,
  });
  final bool isWithWidth;
  final bool isViewAll;
  final Widget? footer;
  final PropertyModel? property;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return GestureDetector(
      onTap: () {
        RouterHandler.navigate(
          context,
          AppRouterKeys.propertyDetails,
          extra: property?.id,
        );
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
                      property?.imageUrl ?? '',
                      fit: BoxFit.cover,
                      height: 124.height,
                      width: double.infinity,
                      borderRadius: BorderRadius.circular(8.radius),
                    ),
                  ),
                ),
                // Positioned(
                //   top: 10.height,
                //   left: 12.width,
                //   child: GestureDetector(
                //     onTap: () => SharePlus.instance.share(
                //       ShareParams(
                //         text:
                //             '${property?.title ?? ''}\n${property?.location ?? ''}',
                //       ),
                //     ),
                //     child: Container(
                //       padding: EdgeInsets.all(6.width),
                //       decoration: BoxDecoration(
                //         color: colors.onPrimary,
                //         shape: BoxShape.circle,
                //       ),
                //       child: ImageItem(
                //         AppImages.savedIcon,
                //         width: 20.width,
                //         color: colors.primaryBrand,
                //       ),
                //     ),
                //   ),
                // ),
           
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.width),
              child: property?.tag != null && property!.tag.isNotEmpty
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
                          ImageItem(AppImages.propertyShapeIcon),
                          SizedBox(width: 4.width),
                          Text(
                            property!.tag,
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
                          property?.location ?? 'Property Location',
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
                                  text: '${formatPrice(property?.price ?? 0)} ',
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
                        label: property?.area ?? '0',
                        icon: AppImages.totalSpaceIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),

                      PropertyItem(
                        label: '${property?.baths ?? 0} ${AppStrings.baths}',
                        icon: AppImages.bathroomIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),

                      PropertyItem(
                        label: '${property?.beds ?? 0} ${AppStrings.beds}',
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
                              text: '${formatPrice(property?.price ?? 0)} ',
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
