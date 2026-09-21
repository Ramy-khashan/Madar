import 'package:flutter/material.dart';

import '../../config/router/app_router_keys.dart';
import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/business/business_home/model/business_portfolio_property_model.dart';
import '../../modules/pages/individual/property_details/model/property_details_model.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/account_role.dart';
import '../utils/functions/common_fun.dart';
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
            publicationRequestStatus:
                portfolio?.publicationRequestStatus ?? '',
            colors: colors,
          ),
          if (AccountRole.isBusiness &&
              portfolio?.financialPerformance != null) ...[
            SizedBox(height: 10.height),
            _PortfolioFinancialStats(
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

class PortfolioCardHeader extends StatelessWidget {
  const PortfolioCardHeader({
    super.key,
    required this.colors,
    required this.title,
    required this.location,
    required this.imageUrl,
    this.publicationRequestStatus = '',
  });
  final String title;
  final String location;
  final String imageUrl;
  final String publicationRequestStatus;
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
        _PublicationStatusTag(status: publicationRequestStatus),
      ],
    );
  }
}

class _PublicationStatusTag extends StatelessWidget {
  const _PublicationStatusTag({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final value = status.trim().toUpperCase();
    // if (value.isEmpty) return const SizedBox.shrink();
    final isApproved = value == 'APPROVED';
    
    final color = isApproved
        ? AppColors.successColor
        :   AppColors.orangeColor
        ;
    final label = isApproved
        ? AppStrings.publishedStatus
        :   AppStrings.notPublishedStatus;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: isApproved ? color.withValues(alpha: 0.12) : AppColors.rate.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(12),
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class _PortfolioFinancialStats extends StatelessWidget {
  const _PortfolioFinancialStats({required this.performance});

  final FinancialPerformance performance;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Row(
          children: [
            _stat(
              context,
              colors,
              AppStrings.totalUnits,
              '${performance.totalChildUnits ?? 0}',
            ),
            SizedBox(width: 8.width),
            _stat(
              context,
              colors,
              AppStrings.activeUnits,
              '${performance.activeChildUnits ?? 0}',
            ),
          ],
        ),
        SizedBox(height: 8.height),
        Row(
          children: [
            _stat(
              context,
              colors,
              AppStrings.occupancyRate,
              performance.occupancyRateLabel,
            ),
            SizedBox(width: 8.width),
            _stat(
              context,
              colors,
              AppStrings.yearlyIncome,
              '${formatPrice(performance.totalIncome?.toDouble() ?? 0)} ${AppStrings.currency}',
            ),
          ],
        ),
      ],
    );
  }

  Widget _stat(
    BuildContext context,
    AppThemeColors colors,
    String label,
    String value,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 8.height),
        decoration: BoxDecoration(
          color: colors.primaryBrand.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.radius),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(10),
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 2.height),
            Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w700,
                color: colors.textFieldTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
