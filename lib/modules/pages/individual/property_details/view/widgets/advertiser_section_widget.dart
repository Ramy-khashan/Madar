 import 'package:flutter/material.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
 import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
 import '../../model/property_details_model.dart';

class AdvertiserSectionWidget extends StatelessWidget {
  const AdvertiserSectionWidget({super.key, required this.advertiser});

  final Publisher? advertiser;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
            Text(
            AppStrings.advertiserDetailsSection,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 12.height),
        Container(
          padding: EdgeInsets.all(16.width),
          decoration: BoxDecoration(
            color: colors.cardBackground,
            borderRadius: BorderRadius.circular(16.radius),
            border: Border.all(color: colors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
        
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 22.width,
                    backgroundColor: colors.primaryBrand.withValues(alpha: .3),
                    child: Icon(
                      Icons.person_outline,
                      color: colors.textSecondary,
                      size: 24.width,
                    ),
                  ),
                  SizedBox(width: 10.width),
                  Expanded(
                    child: Text(
                      advertiser?.fullName ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w700,
                        color: colors.textFieldTitle,
                        fontFamily: AppConstant.appHeaderFont,
                      ),
                    ),
                  ),
                  // if ((advertiser?.badgeLabel ?? '').isNotEmpty)
                  //   Container(
                  //     alignment: Alignment.topCenter,
                  //     margin: EdgeInsetsDirectional.only(
                  //       end: 8.width,
                  //       bottom: 15.height,
                  //     ),
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 10.width,
                  //       vertical: 3.height,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: colors.primaryBrand.withValues(alpha: .1),
                  //       borderRadius: BorderRadius.circular(20.radius),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Icon(
                  //           CupertinoIcons.checkmark_shield,
                  //           size: 16.width,
                  //           color: colors.primaryBrand,
                  //         ),
                  //         SizedBox(width: 4.width),
                  //         Text(
                  //           advertiser!.badgeLabel,
                  //           style: TextStyle(
                  //             fontSize: context.responsiveFontScale(12),
                  //             color: colors.primaryBrand,
                  //             fontFamily: AppConstant.appFont,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                ],
              ),
        
            
              SizedBox(height: 16.height),
        
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 13.height,
                  horizontal: 8.width,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryBrand.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    ImageItem(
                      AppImages.safetyIcon,
                      width: 16.width,
                    ),
                    SizedBox(width: 8.width),
                    Text(
                      '${AppStrings.falLicenseLabel}: \n  ${advertiser?.falLicenseNumber ?? ''} ',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: colors.primaryBrand,
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
        
                    // const Spacer(),
                    // if (advertiser?.isVerified == true)
                    //   Container(
                    //     padding: EdgeInsets.symmetric(
                    //       horizontal: 10.width,
                    //       vertical: 3.height,
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: AppColors.secondBrand.withValues(alpha: .8),
                    //       borderRadius: BorderRadius.circular(20.radius),
                    //       border: Border.all(color: AppColors.secondBrand),
                    //     ),
                    //     child: Text(
                    //       AppStrings.falVerifiedBadge,
                    //       style: TextStyle(
                    //         fontSize: context.responsiveFontScale(12),
                    //         color: colors.onPrimary,
                    //         fontFamily: AppConstant.appHeaderFont,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //   ),
                  ],
                ),
              ),
              SizedBox(height: 8.height),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 13.height,
                  horizontal: 8.width,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryBrand.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                   ImageItem(
                      AppImages.safetyIcon,
                      width: 16.width,
                    ),
                    SizedBox(width: 8.width),
                    Text(
                      '${AppStrings.adLicenseLabel}:\n  ${advertiser?.adLicenseNumber ?? ''} ',
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(13),
                        color: colors.primaryBrand,
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.height),
              AppButton(
                text:
                    '${AppStrings.viewOwnerProperties} (${advertiser?.propertiesCount ?? 0})',
                onTap: () {
                  RouterHandler.navigate(context, AppRouterKeys.ownerProperties);
                },
                 textSize: context.responsiveFontScale(14),
                height: 44.height,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
