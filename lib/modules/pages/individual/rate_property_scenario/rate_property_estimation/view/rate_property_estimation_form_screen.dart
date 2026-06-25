import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../widgets/rate_property_form_item.dart';
import '../controller/rate_property_estimation_bloc.dart';

class RatePropertyEstimationFormScreen extends StatelessWidget {
  const RatePropertyEstimationFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocListener<
      RatePropertyEstimationBloc,
      RatePropertyEstimationState
    >(
      listenWhen: (prev, curr) => prev.analyzeStatus != curr.analyzeStatus,
      listener: (ctx, state) {
        if (state.analyzeStatus == RequestStatus.loading) {
          RouterHandler.navigate(
            context,
            AppRouterKeys.ratePropertyLoading,
            extra: RatePropertyEstimationBloc.get(context),
          );
        }
      },
      child: Scaffold(
        backgroundColor: colors.backgroundPrimary,
        appBar: AppAppbar(title: AppStrings.ratePropertyEstimationTitle),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.responsiveHorizontalPadding,
                    vertical: 16.height,
                  ),
                  child:
                      BlocBuilder<
                        RatePropertyEstimationBloc,
                        RatePropertyEstimationState
                      >(
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                AppStrings.propertyType,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(14),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppConstant.appHeaderFont,
                                  color: colors.textFieldTitle,
                                ),
                              ),
                              SizedBox(height: 8.height),

                              RatePropertyFormItem(
                                ratePropertyArea:
                                    RatePropertyEstimationBloc.get(
                                      context,
                                    ).areaController,
                                propertyLocation:
                                    RatePropertyEstimationBloc.get(
                                      context,
                                    ).locationController,
                                propertyAge: state.propertyAge,
                                finishingLevel: state.finishingLevel,
                                purpose: state.purpose,
                                onPropertyAgeChanged: (v) => context
                                    .read<RatePropertyEstimationBloc>()
                                    .add(
                                      RatePropertyEstimationFieldChanged(
                                        propertyAge: v,
                                      ),
                                    ),
                                onFinishingLevelChanged: (v) => context
                                    .read<RatePropertyEstimationBloc>()
                                    .add(
                                      RatePropertyEstimationFieldChanged(
                                        finishingLevel: v,
                                      ),
                                    ),
                                onPurposeChanged: (v) => context
                                    .read<RatePropertyEstimationBloc>()
                                    .add(
                                      RatePropertyEstimationFieldChanged(
                                        purpose: v,
                                      ),
                                    ),
                                selectedType: state.selectedType,

                                onTapPropertyType: (String p1) {
                                  context
                                      .read<RatePropertyEstimationBloc>()
                                      .add(
                                        RatePropertyEstimationTypeSelected(p1),
                                      );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 12.height,
                ),
                child:
                    BlocBuilder<
                      RatePropertyEstimationBloc,
                      RatePropertyEstimationState
                    >(
                      builder: (context, state) {
                        return AppButton(
                          text: AppStrings.ratePropertyCalculateBtn,

                          onTap: () => context
                              .read<RatePropertyEstimationBloc>()
                              .add(const RatePropertyEstimationCalculate()),
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
