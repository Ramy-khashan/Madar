import 'package:flutter/material.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/individual_home/model/portfolio_property_model.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'app_button.dart';
import 'image_item.dart';

class PortfolioCardWidget extends StatelessWidget {
  const PortfolioCardWidget({
    super.key,
    required this.portfolio,
    this.isWithWidth = false,
  });
  final bool isWithWidth;
  final PortfolioPropertyModel portfolio;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Container(
      width: isWithWidth
          ? context.screenWidth * (context.isTablet ? 0.4 : 0.85)
          : null,
      padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 16.height),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PortfolioCardHeader(
            title: portfolio.title,
            location: portfolio.location,
            status: portfolio.status,
            imageUrl: portfolio.imageUrl,
            colors: colors,
          ),
          SizedBox(height: 10.height),
          // PropertyInfo(
          //   info: '${AppStrings.contractsCount}: ${portfolio.contractCount}',
          //   icon: AppImages.documentsIcon,
          //   colors: colors,
          // ),
          // PropertyInfo(
          //   info:
          //       '${AppStrings.occupancyRate}: ${portfolio.occupancyRate.toInt()}%',
          //   icon: AppImages.occupancyIcon,
          //   colors: colors,
          // ),
          // PropertyInfo(
          //   info: '${AppStrings.lastUpdate}: ${portfolio.lastUpdate}',
          //   icon: AppImages.updateIcon,
          //   colors: colors,
          // ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.location_on_outlined,
          //       size: 16.width,
          //       color: colors.textFieldTitle.withValues(alpha: 0.7),
          //     ),

          //     SizedBox(width: 4.width),
          //     Expanded(
          //       child: Text(
          //         portfolio.location,
          //         style: TextStyle(
          //           fontSize: context.responsiveFontScale(14),
          //           fontFamily: AppConstant.appHeaderFont,
          //           fontWeight: FontWeight.w500,
          //           color: colors.textFieldTitle.withValues(alpha: 0.7),
          //         ),
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 12.height),
          // Row(
          //   children: [
          //     PropertyItem(
          //       label: '${portfolio.bed} ${AppStrings.beds}',
          //       icon: AppImages.bedroomIcon,
          //       colors: colors,
          //     ),
          //     SizedBox(width: 10.width),
          //     PropertyItem(
          //       label: '${portfolio.bath} ${AppStrings.baths}',
          //       icon: AppImages.bathroomIcon,
          //       colors: colors,
          //     ),
          //     SizedBox(width: 10.width),
          //     PropertyItem(
          //       label: portfolio.area,
          //       icon: AppImages.totalSpaceIcon,
          //       colors: colors,
          //     ),
          //   ],
          // ),

          // SizedBox(height: 10.height),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  key: Key('view_details_${portfolio.id}'),
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.myPropertyDetails,
                      extra: portfolio.id,
                    );
                  },
                  text: AppStrings.viewDetails,
                  textSize: context.responsiveFontScale(12),
                ),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: AppButton(
                  key: Key('send_to_broker_${portfolio.id}'),
                  isOutline: true,
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.chooseBroker,
                      extra: portfolio.id,
                    );
                  },
                  text: AppStrings.sendToBrokerProperty,
                  textSize: context.responsiveFontScale(12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PortfolioCardHeader extends StatelessWidget {
  const PortfolioCardHeader({
    super.key,
    required this.colors,
    required this.title,
    required this.location,
    required this.status,
    required this.imageUrl,
  });
  final String title;
  final String location;
  final String status;
  final String imageUrl;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageItem(
          imageUrl,
          width: (context.isTablet ? 72 : 66).width,
          height: 58.height,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.circular(8),
        ),

        SizedBox(width: 12.width),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,

                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.height),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 12.width,
                    color: colors.primaryBrand,
                  ),
                  SizedBox(width: 8.width),

                  Flexible(
                    child: Text(
                      location,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        color: colors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 8.width),

        // Container(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 10.width,
        //     vertical: 4.height,
        //   ),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: isRented ? AppColors.successColor : AppColors.errorColor,
        //     ),
        //     color: isRented
        //         ? AppColors.successColor.withValues(alpha: 0.12)
        //         : AppColors.errorColor.withValues(alpha: 0.12),
        //     borderRadius: BorderRadius.circular(20.radius),
        //   ),
        //   child: Text(
        //     status,
        //     style: TextStyle(
        //       fontSize: context.responsiveFontScale(14),
        //       fontWeight: FontWeight.w600,
        //       fontFamily: AppConstant.appHeaderFont,
        //       color: isRented ? AppColors.successColor : AppColors.errorColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
