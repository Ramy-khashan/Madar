import 'package:flutter/material.dart';

import '../../../../../../../config/router/app_router_keys.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';

class RatePropertyEstimationSuccessDialog extends StatelessWidget {
  const RatePropertyEstimationSuccessDialog({super.key});

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
                onTap: () => RouterHandler.pop(context),
                child: Container(
                  width: 28.width,
                  height: 28.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: colors.primaryBrand, width: 2),
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
            Container(
              width: 64.width,
              height: 64.width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryBrand.withValues(alpha: 0.1),
              ),
              child: Icon(
                Icons.check,
                color: colors.primaryBrand,
                size: 30.width,
              ),
            ),
            SizedBox(height: 16.height),
            Text(
              AppStrings.ratePropertySavedSuccess,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(20),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 24.height),
            AppButton(
              text: AppStrings.goHome,
              textSize: 14,
              height: 48.height,
              onTap: (){
                RouterHandler.navigate(context,AppRouterKeys.navbar,routerType: RouterType.goName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
