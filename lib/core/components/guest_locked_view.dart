import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/guest_mode.dart';
import '../utils/functions/responsive.dart';
import 'app_button.dart';

class GuestLockedView extends StatelessWidget {
  const GuestLockedView({
    super.key,
    this.title,
    this.subtitle,
    this.compact = false,
  });

  final String? title;
  final String? subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final heading = title ?? AppStrings.guestAuthTitle;
    final body = subtitle ?? AppStrings.guestFeaturesMessage;

    if (compact) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
        ),
        child: Material(
          color: colors.primaryBrand.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.radius),
          child: InkWell(
            onTap: () => GuestMode.exitToChooseRole(context),
            borderRadius: BorderRadius.circular(16.radius),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 16.height,
              ),
              child: Row(
                children: [
                  Container(
                    width: 44.width,
                    height: 44.width,
                    decoration: BoxDecoration(
                      color: colors.cardBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: colors.primaryBrand,
                      size: 22.width,
                    ),
                  ),
                  SizedBox(width: 12.width),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          heading,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        SizedBox(height: 4.height),
                        Text(
                          body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14.width,
                    color: colors.primaryBrand,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.width,
              height: 72.width,
              decoration: BoxDecoration(
                color: colors.primaryBrand.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.lock_outline_rounded,
                size: 32.width,
                color: colors.primaryBrand,
              ),
            ),
            SizedBox(height: 20.height),
            Text(
              heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(18),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              body,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                height: 1.4,
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 24.height),
            AppButton(
              text: AppStrings.signIn,
              onTap: () => GuestMode.exitToChooseRole(context),
            ),
          ],
        ),
      ),
    );
  }
}
