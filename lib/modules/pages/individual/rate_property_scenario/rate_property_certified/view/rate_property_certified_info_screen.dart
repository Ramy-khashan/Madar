import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import 'widgets/certified_rate_feature_item.dart';

class RatePropertyCertifiedInfoScreen extends StatelessWidget {
  const RatePropertyCertifiedInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Scaffold(
      backgroundColor: colors.backgroundPrimary,
      appBar: AppAppbar(title: AppStrings.ratePropertyCertifiedTitle),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 16.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.width),
                      decoration: BoxDecoration(
                        color: Theme.brightnessOf(context) == Brightness.dark
                            ? colors.onPrimary.withValues(alpha: 0.05)
                            : colors.primaryBrand.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.radius),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: colors.primaryBrand,
                            size: 20.width,
                          ),
                          SizedBox(width: 12.width),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.ratePropertyCompletionTime,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(16),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppConstant.appHeaderFont,
                                    color: colors.textFieldTitle,
                                  ),
                                ),
                                SizedBox(height: 4.height),
                                Text(
                                  AppStrings.ratePropertyCertifiedTimeDesc,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    color: colors.textSecondary,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.height),
                    OutlinedSection(
                      title: AppStrings.ratePropertyCertifiedFeatures,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FeatureRow(
                            icon: Icons.verified_outlined,
                            title: AppStrings.ratePropertyFeat1Title,
                            desc: AppStrings.ratePropertyFeat1Desc,
                            colors: colors,
                          ),
                          SizedBox(height: 12.height),
                          FeatureRow(
                            icon: CupertinoIcons.shield,
                            title: AppStrings.ratePropertyFeat2Title,
                            desc: AppStrings.ratePropertyFeat2Desc,
                            colors: colors,
                          ),
                          SizedBox(height: 12.height),
                          FeatureRow(
                            icon: Icons.description_outlined,
                            title: AppStrings.ratePropertyFeat3Title,
                            desc: AppStrings.ratePropertyFeat3Desc,
                            colors: colors,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.height),
                    OutlinedSection(
                      title: AppStrings.ratePropertyRequiredDocs,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:
                            [
                                  AppStrings.ratePropertyDoc1,
                                  AppStrings.ratePropertyDoc2,
                                  AppStrings.ratePropertyDoc3,
                                ]
                                .map(
                                  (item) => ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    minVerticalPadding: 0,
                                    leading: Icon(
                                      Icons.check_circle_outline,
                                      color: colors.primaryBrand,
                                      size: 18.width,
                                    ),

                                    title: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: context.responsiveFontScale(
                                          16,
                                        ),
                                        color: colors.textFieldTitle,
                                        fontFamily: AppConstant.appFont,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 12.height,
              ),
              child: AppButton(
                text: AppStrings.ratePropertyStartRequest,
                onTap: () => RouterHandler.navigate(
                  context,
                  AppRouterKeys.ratePropertyCertifiedForm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
