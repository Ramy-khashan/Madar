import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/portfolio_card_widget.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../model/business_property_request_model.dart';

class BusinessPortflioPropertyItem extends StatelessWidget {
  const BusinessPortflioPropertyItem({
    super.key,
    required this.portfolio,
    this.isWithWidth = false,
  });
  final bool isWithWidth;
  final BusinessRequestPublishedPropertyModel portfolio;

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
            imageUrl: portfolio.imageUrl,
            colors: colors,
          ),
          SizedBox(height: 10.height),
          AppButton(
            onTap: () {
              RouterHandler.navigate(
                context,
                AppRouterKeys.propertyFileDetails,
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
