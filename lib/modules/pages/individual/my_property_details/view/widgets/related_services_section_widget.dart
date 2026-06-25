import 'package:flutter/material.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../individual_home/model/smart_service_model.dart';
import '../../../individual_home/view/widgets/smart_service_card_widget.dart';

class RelatedServicesSectionWidget extends StatelessWidget {
  const RelatedServicesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.relatedServices,
          style: TextStyle(
            fontSize: context.responsiveFontScale(16),
            fontWeight: FontWeight.w700,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textFieldTitle,
          ),
        ),
        SizedBox(height: 12.height),
        GridView.count(
          crossAxisCount: ResponsiveUtils.types(
            context,
            mobilePortrait: 2,
            mobileLandscape: 2,
            tabletPortrait: 2,
            tabletLandscape: 3,
          ).toInt(),
          crossAxisSpacing: 12.width,
          mainAxisSpacing: 12.height,
          mainAxisExtent: ResponsiveUtils.types(
            context,
            mobilePortrait: 215.height,
            mobileLandscape: 215.height,
            tabletPortrait: 130.height,
            tabletLandscape: 215.height,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SmartServiceCardWidget(
              service: SmartServiceModel(
                route: '',
                id: '1',
                title: AppStrings.insuranceProperty,
                description: AppStrings.insurancePropertyDescription,
                icon: AppImages.safetyIcon,
              ),
              onTap: () {
                RouterHandler.navigate(
                  context,
                  AppRouterKeys.propertyInsurance,
                );
              },
            ),
            SmartServiceCardWidget(
              service: SmartServiceModel(
                route: '',
                id: '2',
                title: AppStrings.propertyEvaluation,
                description: AppStrings.propertyEvaluationDescription,
                icon: AppImages.ratingIcon,
              ),
              onTap: () {
                RouterHandler.navigate(context, AppRouterKeys.rateProperty);
              },
            ),
          ],
        ),
      ],
    );
  }
}
