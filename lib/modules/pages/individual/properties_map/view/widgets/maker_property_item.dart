import 'package:flutter/material.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/components/property_items.dart';
import '../../../../../../core/model/google_map_model.dart';
import '../../../../../../core/utils/functions/router_handler.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_details/model/property_details_model.dart';

class MarkerInfoCard extends StatelessWidget {
  const MarkerInfoCard({
    super.key,
    required this.colors,
    required this.marker,
    required this.property,
    required this.onClose,
  });

  final AppThemeColors colors;
  final PositionModel? marker;
  final PropertyDetailsModel? property;
  final VoidCallback onClose;

  String get _imageUrl {
    final media = property?.media;
    if (media == null || media.isEmpty) return AppImages.propertyImage;
    final cover = media.coverUrl;
    return cover.isNotEmpty ? cover : AppImages.propertyImage;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: InkWell(
            onTap: () {
              RouterHandler.navigate(
                context,
                AppRouterKeys.propertyDetails,
                extra: property?.propertyId,
              );
            },
            child: Container(
              width: context.isMobilePortrait
                  ? context.screenWidth * 0.91
                  : context.screenWidth * 0.4,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: colors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: details
                  ImageItem(
                    _imageUrl,
                    width: 120.width,
                    height: 140.height,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(14.width),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title + close button row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  property?.title ?? 'Title',
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(16),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstant.appHeaderFont,
                                    color: colors.textFieldTitle,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.width),
                              GestureDetector(
                                onTap: onClose,
                                child: Icon(
                                  Icons.close,
                                  color: colors.textSecondary,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.height),
                          // Location
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: colors.textSecondary,
                              ),
                              SizedBox(width: 2.width),
                              Expanded(
                                child: Text(
                                  (property?.location?.city ?? '') +
                                      (property?.location?.district != null
                                          ? ', ${property?.location?.district}'
                                          : '') +
                                      (property?.location?.street != null
                                          ? ', ${property?.location?.street}'
                                          : ''),
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    color: colors.textSecondary,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.height),
                          // Specs row: beds | balconies | area
                          Row(
                            children: [
                              PropertyItem(
                                icon: AppImages.bedroomIcon,
                                label: '${property?.details?.floorsCount ?? 0}',
                                colors: colors,
                              ),
                              SizedBox(width: 10.width),
                              PropertyItem(
                                icon: AppImages.balconyIcon,
                                label: '${property?.details?.condition ?? 0}',
                                colors: colors,
                              ),
                              SizedBox(width: 10.width),
                              PropertyItem(
                                icon: AppImages.totalSpaceIcon,
                                label: (property?.totalArea ?? '0').toString(),
                                colors: colors,
                              ),
                            ],
                          ),
                          SizedBox(height: 10.height),
                          // Price
                          Text.rich(
                            TextSpan(
                              text: formatPrice(
                                double.parse((property?.price ?? 0).toString()),
                              ),
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(18),
                                fontWeight: FontWeight.w700,
                                color: colors.textFieldTitle,
                                fontFamily: AppConstant.appHeaderFont,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${AppStrings.currency}',
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    fontWeight: FontWeight.w500,
                                    color: colors.textFieldTitle,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
