import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/subscription_bloc.dart';
import '../../model/subscription_plan_model.dart';

class SubscriptionPlanCardWidget extends StatelessWidget {
  const SubscriptionPlanCardWidget({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.billingCycle,
    required this.onTap,
  });

  final SubscriptionPlanModel plan;
  final bool isSelected;
  final SubscriptionBillingCycle billingCycle;
  final VoidCallback onTap;

  String get _badge {
    switch (plan.id) {
      case 'basic':
        return AppStrings.subscriptionBasicBadge;
      case 'pro':
        return AppStrings.subscriptionProBadge;
      case 'featured':
        return AppStrings.subscriptionFeaturedBadge;
      default:
        return plan.badge;
    }
  }

  double get _price => billingCycle == SubscriptionBillingCycle.monthly
      ? plan.monthlyPrice
      : plan.yearlyPrice;

  String get _priceSuffix => billingCycle == SubscriptionBillingCycle.monthly
      ? AppStrings.subscriptionPricePerMonth
      : AppStrings.subscriptionPricePerYear;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 16.height),
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 10.height,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryBrand.withValues(alpha: 0.25)
              : colors.cardBackground,
          borderRadius: BorderRadius.circular(16.radius),
          border: Border.all(
            color: isSelected
                ? colors.primaryBrand.withValues(alpha: .5)
                : colors.borderColor,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: colors.textFieldTitle.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${formatPrice(_price)} $_priceSuffix',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(18),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.primaryBrand,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.width,
                    vertical: 8.height,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.onPrimary
                        : colors.textFieldBorder.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(20.radius),
                  ),
                  child: Text(
                    _badge,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      fontFamily: AppConstant.appFont,
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.height),
              child: Text(
                AppStrings.subscriptionFeaturesLabel,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
            ),
            ...plan.features.map(
              (feature) => Padding(
                padding: EdgeInsets.only(bottom: 16.height),
                child: Row(
                  children: [
                    ImageItem(AppImages.doneIcon, color: colors.primaryBrand),
                    SizedBox(width: 8.width),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontFamily: AppConstant.appFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.height),
              child: AppButton(
                onTap: () => RouterHandler.navigate(
                  context,
                  AppRouterKeys.subscriptionPaymentType,
                  extra: SubscriptionBloc.get(context),
                ),
                text: AppStrings.subscriptionSubscribeNow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
