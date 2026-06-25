import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../controller/rate_property_estimation_bloc.dart';
import 'widgets/spinner_row_item.dart';

class RatePropertyLoadingScreen extends StatelessWidget {
  const RatePropertyLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocListener<
      RatePropertyEstimationBloc,
      RatePropertyEstimationState
    >(
      listenWhen: (prev, curr) => prev.analyzeStatus != curr.analyzeStatus,
      listener: (ctx, state) {
        if (state.analyzeStatus == RequestStatus.success) {
          RouterHandler.navigate(
            context,
            AppRouterKeys.ratePropertyResult,
            routerType: RouterType.pushReplacementNamed,
            extra: RatePropertyEstimationBloc.get(context),
          );
        }
      },
      child:
          BlocBuilder<RatePropertyEstimationBloc, RatePropertyEstimationState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor: colors.backgroundPrimary,
                appBar: AppAppbar(title: AppStrings.ratePropertyTitle),
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsiveHorizontalPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 90.width,
                          height: 90.width,
                          padding: EdgeInsets.all(20.width),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primaryBrand.withValues(alpha: 0.1),
                          ),
                          child: ImageItem(
                          AppImages.occupancyIcon ,
                            color: colors.primaryBrand,
                            
                          ),
                        ),
                        SizedBox(height: 28.height),
                        Text(
                          AppStrings.ratePropertyAnalyzingTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(18),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.cairoFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        SizedBox(height: 8.height),
                        Text(
                          AppStrings.ratePropertyAnalyzingSubtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.cairoFont,
                          ),
                        ),
                        SizedBox(height: 32.height),
                        SpinnerRowItem(
                          label: AppStrings.ratePropertyAnalyzingStep1,
                          colors: colors,
                        ),
                        SizedBox(height: 12.height),
                        SpinnerRowItem(
                          label: AppStrings.ratePropertyAnalyzingStep2,
                          colors: colors,
                        ),
                        SizedBox(height: 12.height),
                        SpinnerRowItem(
                          label: AppStrings.ratePropertyAnalyzingStep3,
                          colors: colors,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
    );
  }
}

