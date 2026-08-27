import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';

class InsuranceSuccessDialog extends StatelessWidget {
  const InsuranceSuccessDialog({super.key, required this.requestNumber});

  final String requestNumber;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.radius)),
      child: Padding(
        padding: EdgeInsets.all(24.width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: GestureDetector(
                onTap: () => RouterHandler.pop(context),
                child: Container(
                  width: 28.width,
                  height: 28.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.primaryBrand, width: 2),
                  ),
                  child: Icon(Icons.close, size: 16.width, color: colors.primaryBrand),
                ),
              ),
            ),
            SizedBox(height: 8.height),
            Container(
              width: 64.width,
              height: 64.width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryBrand.withValues(alpha: 0.1),
              ),
              child: Icon(Icons.check, color: colors.primaryBrand, size: 30.width),
            ),
            SizedBox(height: 16.height),
            Text(
              AppStrings.insuranceRequestSent,
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
                    AppStrings.requestReviewNote,
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
            SizedBox(height: 20.height),
            AppButton(
              text: AppStrings.goHome,
              textSize: 14,
              height: 48.height,
              onTap: () => RouterHandler.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
