import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/info_row_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/insurance_options_bloc.dart';

class InsuranceConfirmSheetWidget extends StatelessWidget {
  const InsuranceConfirmSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<InsuranceOptionsBloc, InsuranceOptionsState>(
      builder: (context, state) {
        final type = state.selectedType;
        final company = state.selectedCompany;
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          builder: (ctx, scrollController) => Container(
            decoration: BoxDecoration(
              color: colors.backgroundPrimary,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24.radius),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 8.height),
                Container(
                  width: 40.width,
                  height: 4.height,
                  decoration: BoxDecoration(
                    color: colors.borderColor,
                    borderRadius: BorderRadius.circular(2.radius),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => RouterHandler.pop(context),
                        child: Container(
                          width: 28.width,
                          height: 28.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: colors.primaryBrand,width: 2),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 16.width,
                            color: colors.primaryBrand,
                          ),
                        ),
                      ),
                      Text(
                        AppStrings.confirmInsuranceTitle,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(18),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textFieldTitle,
                        ),
                      ),
                      SizedBox(width: 28.width),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.width),
                    child: Column(
                      children: [
                        Container(
                          width: 56.width,
                          height: 56.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colors.primaryBrand.withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            Icons.check,
                            color: colors.primaryBrand,
                            size: 28.width,
                          ),
                        ),
                        SizedBox(height: 8.height),
                        Text(
                          AppStrings.reviewRequestTitle,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                        Text(
                          AppStrings.verifyDataSubtitle,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                        SizedBox(height: 20.height),
                        ConfirmCard(
                          title: AppStrings.propertyInfoSection,
                          colors: colors,
                          children: [
                            InfoRow(
                              label: '',
                              value: state.propertyTitle,
                              colors: colors,
                            ),
                            InfoRow(
                              label: AppStrings.rentValueLabel,
                              value:
                                  '${state.propertyPrice.toInt()} ${AppStrings.currency}',
                              colors: colors,
                            ),
                            InfoRow(
                              label: AppStrings.propertyLocationLabel,
                              value: state.propertyLocation,
                              colors: colors,
                            ),
                            InfoRow(
                              label: AppStrings.propertyTypeLabel,
                              value: state.propertyType,
                              colors: colors,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.height),
                        ConfirmCard(
                          title: AppStrings.insuranceTypeSection,
                          colors: colors,
                          children: [
                            InfoRow(
                              label: '',
                              value: type?.name ?? '',
                              colors: colors,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.height),
                              child: Text(
                                '${AppStrings.coverageLabel}: ',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(13),
                                  color: colors.textFieldTitle,
                                  fontFamily: AppConstant.appFont,
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 6.width,
                              runSpacing: 6.height,
                              children: (type?.coverages ?? [])
                                  .map(
                                    (c) => Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.width,
                                        vertical: 4.height,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.primaryBrand.withValues(
                                          alpha: 0.07,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          20.radius,
                                        ),
                                      ),
                                      child: Text(
                                        c,
                                        style: TextStyle(
                                          fontSize: context.responsiveFontScale(
                                            12,
                                          ),
                                          color: colors.primaryBrand,
                                          fontFamily: AppConstant.appFont,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.height),
                        ConfirmCard(
                          title: AppStrings.insuranceCompanySection,
                          colors: colors,
                          children: [
                            InfoRow(
                              label: AppStrings.companyLabel,
                              value: company?.name ?? '',
                              colors: colors,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${AppStrings.ratingLabel}: ',
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(13),
                                    color: colors.textFieldTitle,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                                Text(
                                  '${company?.rating ?? ''} ',
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(13),
                                    color: colors.textFieldTitle,
                                    fontFamily: AppConstant.appFont,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 18.width,
                                  color: AppColors.rate,
                                ),
                              ],
                            ),

                            InfoRow(
                              label: AppStrings.processingTimeLabel,
                              value:
                                  '${company?.processingHours ?? ''} ${AppStrings.processingHoursLabel}',
                              colors: colors,
                            ),
                            InfoRow(
                              label: AppStrings.discountLabel,
                              value: '${company?.discountPercent ?? 0}%',
                              colors: colors,
                            ),
                          ],
                        ),
                        SizedBox(height: 24.height),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.width,
                    vertical: 12.height,
                  ),
                  child: SafeArea(
                    child: AppButton(
                      text: AppStrings.confirmRequestBtn,
                      isLoading: state.confirmStatus == RequestStatus.loading,
                      onTap: () {
                        RouterHandler.pop(context);
                        context.read<InsuranceOptionsBloc>().add(
                          const InsuranceOptionsConfirm(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({
    required this.title,
    required this.children,
    required this.colors,
    super.key,
  });

  final String title;
  final List<Widget> children;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),
          ...children,
        ],
      ),
    );
  }
}
