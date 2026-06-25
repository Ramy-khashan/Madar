import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/insurance_options_bloc.dart';
import 'company_section_widget.dart';
import 'insurance_confirm_sheet_widget.dart';
import 'insurance_type_section_widget.dart';

class InsuranceOptionsContentWidget extends StatelessWidget {
  const InsuranceOptionsContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveHorizontalPadding,
              vertical: 16.height,
            ),
            child: BlocBuilder<InsuranceOptionsBloc, InsuranceOptionsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(24.width),
                      decoration: BoxDecoration(
                        color: colors.backgroundPrimary,
                        borderRadius: BorderRadius.circular(16.radius),
                        border: Border.all(color: colors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.chooseInsuranceType,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textFieldTitle,
                            ),
                          ),
                          SizedBox(height: 12.height),
                          ...state.types.map(
                            (type) => Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 10.height,
                                    bottom: 5.height,
                                  ),
                                  child: InsuranceTypeCard(
                                    type: type,
                                    isSelected: state.selectedTypeId == type.id,
                                    onTap: () => context
                                        .read<InsuranceOptionsBloc>()
                                        .add(
                                          InsuranceOptionsTypeSelected(type.id),
                                        ),
                                  ),
                                ),
                                if (type.isRecommended)
                                  PositionedDirectional(
                                    end: 18.width,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10.width,
                                        vertical: 3.height,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightSuccessColor ,
                                        borderRadius: BorderRadius.circular(
                                          20.radius,
                                        ),
                                      ),
                                      child: Text(
                                        AppStrings.recommendedBadge,
                                        style: TextStyle(
                                          fontSize: context.responsiveFontScale(
                                            11,
                                          ),
                                          color: colors.onPrimary,
                                          fontFamily: AppConstant.appFont,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.height),
                      padding: EdgeInsets.all(24.width),
                      decoration: BoxDecoration(
                        color: colors.backgroundPrimary,
                        borderRadius: BorderRadius.circular(16.radius),
                        border: Border.all(color: colors.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.chooseInsuranceCompany,
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appHeaderFont,
                              color: colors.textFieldTitle,
                            ),
                          ),
                          SizedBox(height: 12.height),
                          Column(
                            children: List.generate(state.companies.length, (
                              index,
                            ) {
                              final company = state.companies[index];
                              final isSelected =
                                  state.selectedCompanyId == company.id;
                              final isLast =
                                  index == state.companies.length - 1;
                              return CompanyTile(
                                company: company,
                                isSelected: isSelected,
                                isLast: isLast,
                                onTap: () =>
                                    context.read<InsuranceOptionsBloc>().add(
                                      InsuranceOptionsCompanySelected(
                                        company.id,
                                      ),
                                    ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Card(
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.radius),
                      ),
                      elevation: 0,
                      color: colors.primaryBrand.withValues(alpha: 0.24),
                      child: Padding(
                        padding: EdgeInsets.all(16.width),
                        child: Column(
                          children: [
                            Text(
                              'التكلفة السنوية بعد الخصم',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                color: colors.textSecondary,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.height,
                              ),
                              child: Text(
                                ' 1,145${AppStrings.currency}',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(16),
                                  color: colors.primaryBrand,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppConstant.appHeaderFont,
                                ),
                              ),
                            ),
                            Text(
                              'وفرت 96 ${AppStrings.currency} 🎉',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textSecondary,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveHorizontalPadding,
            vertical: 12.height,
          ),

          child: BlocBuilder<InsuranceOptionsBloc, InsuranceOptionsState>(
            builder: (context, state) {
              final canProceed =
                  state.selectedTypeId != null &&
                  state.selectedCompanyId != null;
              return AppButton(
                text: AppStrings.continueToConfirm,
                onTap: canProceed
                    ? () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.radius),
                          ),
                        ),
                        builder: (_) => BlocProvider.value(
                          value: context.read<InsuranceOptionsBloc>(),
                          child: const InsuranceConfirmSheetWidget(),
                        ),
                      )
                    : null,
                colorBG: canProceed ? null : Colors.grey.shade400,
              );
            },
          ),
        ),
      ],
    );
  }
}
