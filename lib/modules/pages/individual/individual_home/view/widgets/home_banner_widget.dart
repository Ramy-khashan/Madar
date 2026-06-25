import 'package:flutter/material.dart';

import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.radius),
        child: SizedBox(
          height: 163.height,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(AppImages.bannerImage, fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff0A1E3C).withValues(alpha: 0.8),
                      Color(0xff0A1D38).withValues(alpha: 0.2),
                    ],
                    end: AlignmentDirectional.centerEnd,
                    begin: AlignmentDirectional.centerStart,
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(16.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.bannerTitle,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w700,
                        fontFamily: AppConstant.appHeaderFont,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6.height),
                    Text(
                      AppStrings.bannerDesc,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(11),
                        fontFamily: AppConstant.appHeaderFont,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
