import 'package:flutter/material.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/business_portfolio_property_model.dart';

class BusinessPortflioPropertyItem extends StatelessWidget {
  const BusinessPortflioPropertyItem({
    super.key,
    required this.portfolio,
    this.isWithWidth = false,
  });
  final bool isWithWidth;
  final BusinessPortfolioPropertyModel portfolio;

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
          PropertyInfo(
            info: '${AppStrings.contractsCount}: ${portfolio.contractNumber}',
            icon: AppImages.documentsIcon,
            colors: colors,
          ),
          PropertyInfo(
            info:
                '${AppStrings.occupancyRate}: ${portfolio.occupancyRate.toInt()}%',
            icon: AppImages.occupancyRateIcon,
            colors: colors,
          ),
          PropertyInfo(
            info: '${AppStrings.lastUpdate}: ${portfolio.lastUpdate}',
            icon: AppImages.updateIcon,
            colors: colors,
          ),

          SizedBox(height: 10.height),
          AppButton(
            onTap: () {
              RouterHandler.navigate(
                context,
                AppRouterKeys.myPropertyDetails,
                extra: portfolio.id,
              );
            },
            childText: AppStrings.viewDetails,
          ),
        ],
      ),
    );
  }
}

class PropertyInfo extends StatelessWidget {
  const PropertyInfo({
    super.key,
    required this.info,
    required this.icon,
    required this.colors,
  });
  final String info;
  final String icon;
  final AppThemeColors colors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.height),
      child: Row(
        children: [
          ImageItem(icon, width: 16.width, color: colors.primaryBrand),
          SizedBox(width: 6.width),
          Text(
            info,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w800,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
