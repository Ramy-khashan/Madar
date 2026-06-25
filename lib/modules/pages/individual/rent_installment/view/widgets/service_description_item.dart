
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class ServiceDescriptionSection extends StatelessWidget {
  const ServiceDescriptionSection({super.key, required this.colors});
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.width,
                backgroundColor: AppColors.backgroundLight,
                child: const ImageItem(AppImages.rentIcon),
              ),

              SizedBox(width: 10.width),
              Text(
                AppStrings.rentInstallmentInfoTitle,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(18),
                  fontWeight: FontWeight.w700,
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textFieldTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.height),
          Text(
            AppStrings.rentInstallmentInfoDescription,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              color: colors.textFieldTitle,
              height: 1.6,
            ),
          ),
          SizedBox(height: 12.height),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_outline_rounded,
                size: 16.width,
                color: AppColors.lightSuccessColor,
              ),
              SizedBox(width: 6.width),
              Expanded(
                child: Text(
                  AppStrings.rentInstallmentEligibleNote,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: AppColors.lightSuccessColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
