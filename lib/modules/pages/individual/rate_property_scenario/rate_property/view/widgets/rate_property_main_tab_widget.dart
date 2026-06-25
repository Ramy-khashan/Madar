import 'package:flutter/material.dart';

import '../../../../../../../config/router/app_router_keys.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';
import 'rate_options_card.dart';

class RatePropertyMainTabWidget extends StatelessWidget {
  const RatePropertyMainTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 8.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.width),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.radius),
                    border: Border.all(color: colors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.width),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colors.primaryBrand.withValues(alpha: 0.1),
                            ),
                            child: const ImageItem(AppImages.rateIcon),
                          ),
                          SizedBox(width: 8.width),
            
                          Expanded(
                            child: Text(
                              AppStrings.ratePropertyTitle,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(18),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textFieldTitle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.height),
                      Text(
                        AppStrings.ratePropertyWhatIsDesc,
                         style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.height),
                RateOptionCard(
                  title: AppStrings.ratePropertyEstimationCardTitle,
                  badge: AppStrings.ratePropertyEstimationCardFree,
                  badgeColor: AppColors.successColor,
                  subtitle: AppStrings.ratePropertyEstimationCardSubtitle,
                  timeSuffix: AppStrings.ratePropertyEstimationCardTime,
                  icon: AppImages.freeRateIcon,
                  colors: colors,
                  onTap: () => RouterHandler.navigate(context, AppRouterKeys.ratePropertyEstimationForm),
                ),
                SizedBox(height: 12.height),
                RateOptionCard(
                  title: AppStrings.ratePropertyCertifiedCardTitle,
                  badge: AppStrings.ratePropertyCertifiedCardPaid,
                  badgeColor: Colors.orange,
                  subtitle: AppStrings.ratePropertyCertifiedCardSubtitle,
                  timeSuffix: AppStrings.ratePropertyCertifiedCardTime,
                  icon: AppImages.paidRateIcon,
                  colors: colors,
                  onTap: () => RouterHandler.navigate(context, AppRouterKeys.ratePropertyCertifiedInfo),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
