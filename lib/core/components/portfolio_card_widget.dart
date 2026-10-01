import 'package:flutter/material.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/business/business_home/model/business_portfolio_property_model.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/account_role.dart';
import '../utils/functions/responsive.dart';
import '../utils/functions/router_handler.dart';
import 'app_button.dart';
import 'portfolio_card_header.dart';
import 'portfolio_financial_stats.dart';

class PortfolioCardWidget extends StatelessWidget {
  const PortfolioCardWidget({
    super.key,
    required this.portfolio,
    this.isWithWidth = false,
  });
  final bool isWithWidth;
  final MyPropertiesModel? portfolio;

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
            title: portfolio?.title ?? 'Property Title',
            location: portfolio?.location ?? 'Location',
            imageUrl: portfolio?.imageUrl ?? '',
            publicationRequestStatus: portfolio?.publicationRequestStatus ?? '',
            colors: colors,
          ),
          if (AccountRole.isBusiness &&
              portfolio?.financialPerformance != null) ...[
            SizedBox(height: 10.height),
            PortfolioFinancialStats(
              performance: portfolio!.financialPerformance!,
            ),
          ],
          SizedBox(height: 10.height),

          Row(
            children: [
              Expanded(
                child: AppButton(
                  key: Key('view_details_${portfolio?.id}'),
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.propertyFileDetails,
                      extra: portfolio?.id,
                    );
                  },
                  text: AppStrings.viewDetails,
                  textSize: context.responsiveFontScale(12),
                ),
              ),
              SizedBox(width: 12.width),
              Expanded(
                child: AppButton(
                  key: Key('send_to_broker_${portfolio?.id}'),
                  isOutline: true,
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.chooseBroker,
                      extra: portfolio?.id,
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
