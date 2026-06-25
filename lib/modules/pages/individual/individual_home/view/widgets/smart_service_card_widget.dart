import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/smart_service_model.dart';

class SmartServiceCardWidget extends StatelessWidget {
  const SmartServiceCardWidget({
    super.key,
    required this.service,
    required this.onTap,
  });

  final SmartServiceModel service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Container(
      padding: EdgeInsets.all(12.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(8.radius),
        border: Border.all(color: colors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.center,
            child: Container(
              width: 48.width,
              height: 48.width,
              padding: EdgeInsets.symmetric(
                horizontal: 14.width,
                vertical: 12.5.height,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.radius),
                color: colors.primaryBrand.withValues(alpha: 0.2),
              ),
              child: ImageItem(service.icon, width: 24.width),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 14.height, bottom: 8.height),
            child: Text(
              service.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w600,
                color: colors.textFieldTitle,
                fontFamily: AppConstant.cairoFont,
              ),
            ),
          ),
          Text(
            service.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: context.responsiveFontScale(11),
              color: colors.textSecondary,
              fontFamily: AppConstant.cairoFont,
            ),
          ),
          const Spacer(),
          AppButton(
            key: Key('smart_service_card_button_${service.id}'),
            onTap: onTap,
            childText: AppStrings.more,
            height: 32.height,
            textSize: 14,
          ),
        ],
      ),
    );
  }
}
