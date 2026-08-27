import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/info_card_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/property_insurance_bloc.dart';
import '../../model/property_insurance_model.dart';
import 'insurance_offer_item.dart';
import 'insurance_profit.dart';

part 'insurance_coverage_details_section.dart';

class InsuranceInfoTabWidget extends StatelessWidget {
  const InsuranceInfoTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<PropertyInsuranceBloc, PropertyInsuranceState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 8.height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.width),
                      decoration: BoxDecoration(
                        color: colors.cardBackground,
                        borderRadius: BorderRadius.circular(16.radius),
                        border: Border.all(color: colors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.width),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundLight,
                                  borderRadius: BorderRadius.circular(
                                    10.radius,
                                  ),
                                ),
                                child: Icon(
                                  Icons.shield_outlined,
                                  color: AppColors.primary300,
                                  size: 22.width,
                                ),
                              ),
                              SizedBox(width: 10.width),
                              Text(
                                AppStrings.propertyInsuranceScreenTitle,
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(18),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: AppConstant.appHeaderFont,
                                  color: colors.textFieldTitle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.height),
                          Text(
                            AppStrings.insuranceInfoDescription,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              color: colors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 12.height),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_outline_rounded,
                                size: 16.width,
                                color: AppColors.secondBrand,
                              ),
                              SizedBox(width: 6.width),
                              Expanded(
                                child: Text(
                                  AppStrings.insuranceEligibleNote,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(14),
                                    color: AppColors.secondBrand,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.height),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.insuranceTypesSectionTitle,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(18),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        SizedBox(height: 10.height),

                        InsuranceProfit(
                          title: AppStrings.basicInsuranceTitle,
                          features: [
                            AppStrings.basicInsuranceFeature1,
                            AppStrings.basicInsuranceFeature2,
                            AppStrings.basicInsuranceFeature3,
                          ],
                        ),

                        SizedBox(height: 10.height),
                        InsuranceProfit(
                          title: AppStrings.comprehensiveInsuranceTitle,
                          features: [
                            AppStrings.comprehensiveInsuranceFeature1,
                            AppStrings.comprehensiveInsuranceFeature2,
                            AppStrings.comprehensiveInsuranceFeature3,
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16.height),
                    InsuranceCoverageDetailsSection(
                      risks: state.coverageRisks,
                      colors: colors,
                    ),
                    SizedBox(height: 16.height),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.offersComparisonTitle,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(15),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        SizedBox(height: 10.height),
                        ...state.offers.map(
                          (offer) => Padding(
                            padding: EdgeInsets.only(bottom: 10.height),
                            child: OfferCard(offer: offer, colors: colors),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.height),
                    InfoCardItem(title: AppStrings.pricesFinalNote),
                    SizedBox(height: 16.height),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsiveHorizontalPadding,
                vertical: 16.height,
              ),
              child: AppButton(
                text: AppStrings.choosePropertyForInsurance,
                onTap: () {
                  if (!GuestMode.requireAuth(
                    context,
                    subtitle: AppStrings.guestFeaturesMessage,
                  )) {
                    return;
                  }
                  RouterHandler.navigate(context, AppRouterKeys.myProperties);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
