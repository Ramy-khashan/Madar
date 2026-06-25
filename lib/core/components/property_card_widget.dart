import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/properties/model/properties_item_model.dart';
import 'image_item.dart';
 import '../utils/constants/app_constant.dart';
import '../utils/constants/app_images.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import '../../config/router/app_router_keys.dart';
import '../utils/functions/common_fun.dart';
import 'property_items.dart';

class PropertyCardWidget extends StatefulWidget {
  const PropertyCardWidget({
    super.key,
    required this.property,
    this.footer,
    this.isWithWidth = false,
  });
  final bool isWithWidth;
  final Widget? footer;
  final PropertiesItemModel? property;

  @override
  State<PropertyCardWidget> createState() => _PropertyCardWidgetState();
}

class _PropertyCardWidgetState extends State<PropertyCardWidget> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final images = widget.property?.media ?? [];

    return GestureDetector(
      onTap: () {
        RouterHandler.navigate(context, AppRouterKeys.propertyDetails);
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: widget.isWithWidth
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
                    child: SizedBox(
                      height: 124.height,
                      child: images.isEmpty
                          ? ImageItem(
                              '',
                              fit: BoxFit.cover,
                              height: 124.height,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(8.radius),
                            )
                          : PageView.builder(
                              itemCount: images.length,
                              onPageChanged: (i) =>
                                  setState(() => _currentPage = i),
                              itemBuilder: (_, i) => ImageItem(
                                images[i].url ?? '',
                                fit: BoxFit.cover,
                                height: 124.height,
                                width: double.infinity,
                              ),
                            ),
                    ),
                  ),
                ),
                if (images.length > 1)
                  Positioned(
                    bottom: 14.height,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 2.width),
                          width: _currentPage == i ? 12.width : 6.width,
                          height: 6.height,
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4.radius),
                          ),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 10.height,
                  left: 12.width,
                  child: GestureDetector(
                    onTap: () => SharePlus.instance.share(
                      ShareParams(
                        text: '${widget.property?.projectName ?? 'Project Title'}\n${widget.property?.location ?? ' Project Location'}',
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(6.width),
                      decoration: BoxDecoration(
                        color: colors.onPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bookmark_border,
                        size: 20.width,
                        color: colors.primaryBrand,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.width),
              child: widget.property?.type != null && widget.property?.type!.isNotEmpty == true
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
                          ImageItem(
                            AppImages.propertyShapeIcon,
                           ),
                      SizedBox(width: 4.width),
                      Text(
                            widget.property?.type ?? 'Property Type',
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
                    widget.property?.projectName ?? 'Project Name',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConstant.appHeaderFont,
                      color: colors.textFieldTitle,
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
                          widget.property?.location?.city ?? 'Property Location',
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
                        label: '${widget.property?.details?.bedrooms ?? 0} ${AppStrings.beds}',
                        icon: AppImages.bedroomIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),
                      PropertyItem(
                        label: '${widget.property?.details?.bathrooms ?? 0} ${AppStrings.baths}',
                        icon: AppImages.bathroomIcon,
                        colors: colors,
                      ),
                      SizedBox(width: 10.width),
                      PropertyItem(
                        label: '${widget.property?.totalArea ?? 0}',
                        icon: AppImages.totalSpaceIcon,
                        colors: colors,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.height),

                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${formatPrice((widget.property?.price ?? 0).toDouble())} ',
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
                  if (widget.footer != null) widget.footer!,
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
