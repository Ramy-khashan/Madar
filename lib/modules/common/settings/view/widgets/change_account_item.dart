import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/responsive.dart';

class ChangeAccountItem extends StatelessWidget {
  const ChangeAccountItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.width),
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        borderRadius: BorderRadius.circular(16),

        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.width,
            vertical: 16.height,
          ),
          decoration: BoxDecoration(
            color: AppThemeColors.of(context).primaryBrand,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 50.width,
                height: 50.width,
                padding: EdgeInsetsDirectional.all(8.width),
                decoration: BoxDecoration(
                  color: AppThemeColors.of(context).borderColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ImageItem(
                  (PreferenceUtils().getString(StorageKeys.accountType) ==
                          AppConstant.business)
                      ? AppImages.accountIcon
                      : AppImages.changeAccountIcon,
                  color: AppThemeColors.of(context).primaryBrand,
                ),
              ),
              SizedBox(width: 16.width),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      PreferenceUtils().getString(StorageKeys.accountType) ==
                              AppConstant.business
                          ? AppStrings.changeAccountIndividual
                          : AppStrings.changeAccount,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontWeight: FontWeight.w500,
                        color: AppThemeColors.of(context).onPrimary,
                      ),
                    ),
                    SizedBox(height: 4.height),
                    Text(
                      (PreferenceUtils().getString(StorageKeys.accountType) ==
                              AppConstant.business)
                          ? AppStrings.personalAccountHint
                          : AppStrings.changeAccountHint,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(12),
                        color: AppThemeColors.of(context).onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppThemeColors.of(context).onPrimary,
                size: 16.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
