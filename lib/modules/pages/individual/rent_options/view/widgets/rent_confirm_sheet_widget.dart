import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rent_options_bloc.dart';
import '../../model/row_model.dart';

class RentConfirmSheetWidget extends StatelessWidget {
  const RentConfirmSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<RentOptionsBloc, RentOptionsState>(
      builder: (context, state) {
        final plan = state.selectedPlan;
        final provider = state.selectedProvider;
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
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 28.width,
                          height: 28.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colors.primaryBrand,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 16.width,
                            color: colors.primaryBrand,
                          ),
                        ),
                      ),
                      Text(
                        AppStrings.confirmInstallmentTitle,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),
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

                        Padding(
                          padding: EdgeInsets.only(
                            top: 8.height,
                            bottom: 4.height,
                          ),
                          child: Text(
                            AppStrings.reviewRequestTitle,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textFieldTitle,
                            ),
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
                          rows: [
                            RowModel(label: state.propertyTitle, value: ''),
                            RowModel(
                              label: AppStrings.rentValueLabel,
                              value:
                                  '${state.propertyPrice.toInt()} ${AppStrings.currency}',
                            ),
                            RowModel(
                              label: AppStrings.propertyLocationLabel,
                              value: state.propertyLocation,
                            ),
                            RowModel(
                              label: AppStrings.propertyTypeLabel,
                              value: state.propertyType,
                            ),
                          ],
                          colors: colors,
                        ),
                        SizedBox(height: 12.height),
                        ConfirmCard(
                          title: AppStrings.installmentPlanSection,
                          rows: [
                            RowModel(
                              label: AppStrings.installmentPlanLabel,
                              value:
                                  '${plan?.monthsCount ?? ''} ${AppStrings.installmentsSuffix}',
                            ),
                            RowModel(
                              label: AppStrings.monthlyPaymentLabel,
                              value:
                                  '${plan?.monthlyAmount.toInt() ?? 0} ${AppStrings.currency}',
                            ),
                            RowModel(
                              label: AppStrings.adminFeesLabel,
                              value:
                                  '${plan?.fees.toInt() ?? 0} ${AppStrings.currency}',
                            ),
                          ],
                          colors: colors,
                        ),
                        SizedBox(height: 12.height),
                        ConfirmCard(
                          title: AppStrings.chooseInstallmentProvider,
                          rows: [
                            RowModel(
                              label: AppStrings.providerLabel,
                              value: provider?.name ?? '',
                            ),
                            RowModel(
                              label: AppStrings.ratingLabel,
                              value: '${provider?.rating ?? ''} ⭐',
                            ),
                            RowModel(
                              label: AppStrings.processingTimeLabel,
                              value:
                                  '${provider?.processingHours ?? ''} ${AppStrings.processingHoursLabel}',
                            ),
                          ],
                          colors: colors,
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
                  child: AppButton(
                    text: AppStrings.confirmRequestBtn,
                    isLoading: state.confirmStatus == RequestStatus.loading,
                    onTap: () {
                      Navigator.pop(context);
                      context.read<RentOptionsBloc>().add(
                        const RentOptionsConfirm(),
                      );
                    },
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
    required this.rows,
    required this.colors,
    super.key,
  });

  final String title;
  final List<RowModel> rows;
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
          ...rows
              .where((r) => r.value.isNotEmpty || r.label.isNotEmpty)
              .map(
                (r) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.height),
                  child: r.value.isEmpty
                      ? Text(
                          r.label,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              '${r.label}: ',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textFieldTitle,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                            Text(
                              r.value,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
        ],
      ),
    );
  }
}
