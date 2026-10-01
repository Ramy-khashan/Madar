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
import '../../../../../common/chats/chat_navigator.dart';
import '../../model/property_details_model.dart';
import 'license_row.dart';

class AdvertiserSectionWidget extends StatelessWidget {
  const AdvertiserSectionWidget({super.key, required this.advertiser});

  final Publisher? advertiser;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final falLicense = (advertiser?.falLicenseNumber ?? '').trim();
    final adLicense = (advertiser?.adLicenseNumber ?? '').trim();
    final hasLicenses = falLicense.isNotEmpty || adLicense.isNotEmpty;
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
                    child: ClipOval(
                      child: (advertiser?.image ?? '').isNotEmpty
                          ? ImageItem(
                              advertiser!.image!,
                              width: 44.width,
                              height: 44.width,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.person_outline,
                              color: colors.textSecondary,
                              size: 24.width,
                            ),
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
                  if (!hasLicenses) ...[
                    SizedBox(width: 8.width),
                    SizedBox(
                      width: 44.width,
                      height: 44.width,
                      child: AppButton(
                        isOutline: true,
                        childImage: AppImages.chatIcon,
                        onTap: () => _openOwnerChat(context),
                      ),
                    ),
                  ],
                ],
              ),
              if (hasLicenses) ...[
                SizedBox(height: 16.height),
                if (falLicense.isNotEmpty)
                  LicenseRow(
                    colors: colors,
                    text: '${AppStrings.falLicenseLabel}: \n  $falLicense',
                  ),
                if (falLicense.isNotEmpty && adLicense.isNotEmpty)
                  SizedBox(height: 8.height),
                if (adLicense.isNotEmpty)
                  LicenseRow(
                    colors: colors,
                    text: '${AppStrings.adLicenseLabel}:\n  $adLicense',
                  ),
              ],
              SizedBox(height: 16.height),
              AppButton(
                text: AppStrings.viewOwnerProperties,
                onTap: () {
                  RouterHandler.navigate(
                    context,
                    AppRouterKeys.brokerProperties,
                    extra: advertiser?.userId,
                  );
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

  void _openOwnerChat(BuildContext context) {
    ChatNavigator.openPrivateChat(
      context,
      receiverId: advertiser?.userId ?? '',
      participantName: advertiser?.fullName ?? '',
      participantAvatarUrl: advertiser?.image,
    );
  }
}
