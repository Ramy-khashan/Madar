import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../widgets/rate_property_ai_price_card.dart';
import '../controller/rate_property_estimation_bloc.dart';
import 'widgets/rate_property_estimation_success_dialog.dart';

class RatePropertyResultScreen extends StatelessWidget {
  final RatePropertyEstimationBloc bloc;
  const RatePropertyResultScreen({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocProvider.value(
      value: bloc,
      child:
          BlocConsumer<RatePropertyEstimationBloc, RatePropertyEstimationState>(
            listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
            listener: (ctx, state) {
              if (state.saveStatus == RequestStatus.success) {
                showDialog(
                  context: ctx,
                  builder: (_) => const RatePropertyEstimationSuccessDialog(),
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: colors.backgroundPrimary,
                appBar: AppAppbar(title: AppStrings.ratePropertyResultTitle),
                body: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.responsiveHorizontalPadding,
                            vertical: 16.height,
                          ),
                          child: Column(
                            children: [
                              RatePropertyAiPriceCard(
                                minValue: state.minValue,
                                maxValue: state.maxValue,
                                periodDays: state.periodDays,
                                dealsCount: state.dealsCount,
                              ),
                              SizedBox(height: 24.height),
                              OutlinedSection(
                                title: AppStrings.ratePropertyWhyEvaluation,
                                child: Column(
                                  children: [
                                    ...[
                                      'تحليل ${state.dealsCount} صفقة مشابهة',
                                      AppStrings.ratePropertyReason2,
                                      AppStrings.ratePropertyReason3,
                                      AppStrings.ratePropertyReason4,
                                      AppStrings.ratePropertyReason5,
                                    ].map((e) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.height,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const ImageItem(
                                              AppImages.doneIcon,
                                              color:
                                                  AppColors.lightSuccessColor,
                                            ),
                                            SizedBox(width: 8.width),
                                            Expanded(
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                  fontSize: context
                                                      .responsiveFontScale(14),
                                                  fontFamily:
                                                      AppConstant.appFont,
                                                  color: colors.textFieldTitle,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveHorizontalPadding,
                          vertical: 12.height,
                        ),
                        child: AppButton(
                          text: AppStrings.ratePropertySaveBtn,
                          isLoading: state.saveStatus == RequestStatus.loading,
                          onTap: () => context
                              .read<RatePropertyEstimationBloc>()
                              .add(const RatePropertyEstimationSave()),
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
