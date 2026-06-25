import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/image_item.dart';
import '../../../../core/utils/constants/app_constant.dart';
import '../../../../core/utils/constants/app_images.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SplashBloc(this)..add(const InitAppEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandColor = Theme.of(context).brightness == Brightness.dark
        ? AppThemeColors.of(context).onPrimary
        : AppThemeColors.of(context).primaryBrand;

    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.isDoneSplash) {
            if (state.isOnboardingCompleted) {
              if (state.isHaveToken) {
                RouterHandler.navigate(
                  context,
                  state.role == "developer"
                      ? AppRouterKeys.projectManagerHome
                      : AppRouterKeys.navbar,
                );
              } else {
                RouterHandler.navigate(context, AppRouterKeys.chooseAccount);
              }
            } else {
              RouterHandler.navigate(context, AppRouterKeys.onBoarding);
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
                          opacity: _bloc.logoOpacity,
                          child: ScaleTransition(
                            scale: _bloc.logoScale,
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
                      position: _bloc.textSlide,
                      child: FadeTransition(
                        opacity: _bloc.textOpacity,
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
                      position: _bloc.textSlide,
                      child: FadeTransition(
                        opacity: _bloc.textOpacity,
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
              Align(
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
      ),
    );
  }
}
