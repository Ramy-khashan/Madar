import 'package:flutter/material.dart';

import '../../../../../../../config/router/app_router_keys.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/components/outline_section.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';

class RatePropertyCertifiedSuccessDialog extends StatelessWidget {
  const RatePropertyCertifiedSuccessDialog({
    super.key,
    required this.requestNumber,
  });

  final String requestNumber;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 28.width,
                  height: 28.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.primaryBrand, width: 2),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16.width,
                    color: colors.primaryBrand,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.height),
            CircleAvatar(
              radius: 42.width,
              backgroundColor: colors.primaryBrand.withValues(alpha: 0.1),

              child: Icon(
                Icons.check,
                color: colors.primaryBrand,
                size: 35.width,
              ),
            ),
            SizedBox(height: 16.height),
            Text(
              AppStrings.ratePropertyCertifiedSuccess,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(24),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              '${AppStrings.requestNumberLabel}: $requestNumber',
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
            SizedBox(height: 12.height),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.width),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primaryBrand.withValues(alpha: 0.07),
                    AppColors.successColor.withValues(alpha: 0.07),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12.radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.width,
                        height: 8.width,
                        decoration: const BoxDecoration(
                          color: AppColors.secondBrand,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.width),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${AppStrings.requestStatusLabel}:  ',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textFieldTitle,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                            TextSpan(
                              text: AppStrings.newStatusBadge,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: AppColors.secondBrand,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.height),
                  Text(
                    AppStrings.ratePropertyRequestPending,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: colors.textSecondary,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.height),
            OutlinedSection(
              title: AppStrings.ratePropertyNextSteps,
              child: Column(
                children:
                    [
                          AppStrings.ratePropertyNs1,
                          AppStrings.ratePropertyNs2,
                          AppStrings.ratePropertyNs3,
                        ]
                        .map(
                          (item) => ListTile(
                            minVerticalPadding: 0,
                            contentPadding: EdgeInsets.zero,

                            title: Text(
                              item,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textFieldTitle,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 12.width,
                              backgroundColor: colors.primaryBrand.withValues(
                                alpha: 0.05,
                              ),
                              child: Icon(
                                Icons.check_circle_outline,
                                color: colors.primaryBrand,
                                size: 18.width,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 20.height),
            AppButton(
              text: AppStrings.goHome,
              textSize: 14,
              height: 48.height,
              onTap: () => RouterHandler.navigate(
                context,
                AppRouterKeys.navbar,
                routerType: RouterType.goName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
