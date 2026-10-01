import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madar_app/core/utils/constants/app_enums.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/image_item.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(const InitAppEvent()),
      child: Builder(
        builder: (context) {
          final bloc = context.read<SplashBloc>();
          final brandColor = Theme.of(context).brightness == Brightness.dark
              ? AppThemeColors.of(context).onPrimary
              : AppThemeColors.of(context).primaryBrand;

          return BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state.isDoneSplash) {
                if (state.isOnboardingCompleted) {
                  if (state.isHaveToken ||
                      (state.isGuest && state.role == AppConstant.individual)) {
                    RouterHandler.navigate(
                      context,
                      state.role == AppConstant.developer
                          ? AppRouterKeys.projectManagerHome
                          : AppRouterKeys.navbar,
                      routerType: RouterType.pushReplacementNamed,
                    );
                  } else {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.chooseAccount,
                      routerType: RouterType.pushReplacementNamed,
                    );
                  }
                } else {
                  RouterHandler.navigate(
                    context,
                    AppRouterKeys.onBoarding,
                    routerType: RouterType.pushReplacementNamed,
                  );
                }
              }
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            FadeTransition(
                              opacity: bloc.logoOpacity,
                              child: ScaleTransition(
                                scale: bloc.logoScale,
                                child: ImageItem(
                                  AppImages.splashLogo,
                                  height: 82.height,
                                  width: 105.width,
                                  color: brandColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SlideTransition(
                          position: bloc.textSlide,
                          child: FadeTransition(
                            opacity: bloc.textOpacity,
                            child: Text(
                              AppConstant.splashName,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(48),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appFont,
                                color: brandColor,
                              ),
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: bloc.textSlide,
                          child: FadeTransition(
                            opacity: bloc.textOpacity,
                            child: Text(
                              AppConstant.splashEnName,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(15),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 8,
                                fontFamily: AppConstant.appHeaderFont,
                                color: brandColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: ImageItem(
                      AppImages.splashBg,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
