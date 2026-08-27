import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/rate_property_certified_bloc.dart';

class Step3Companies extends StatelessWidget {
  const Step3Companies({super.key, required this.colors, required this.state});

  final AppThemeColors colors;
  final RatePropertyCertifiedState state;

  @override
  Widget build(BuildContext context) {
    if (state.companiesStatus == RequestStatus.loading) {
      return Center(
        child: CircularProgressIndicator(color: colors.primaryBrand),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 16.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(14.width),
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.radius),
              border: Border.all(
                color: colors.primaryBrand.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.shield,
                  color: colors.primaryBrand,
                  size: 20.width,
                ),
                SizedBox(width: 8.width),

                Expanded(
                  child: Text(
                    AppStrings.ratePropertyCompaniesNotice,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.primaryBrand,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.height),
          ...List.generate(state.companies.length, (i) {
            final company = state.companies[i];
            final isSelected = state.selectedCompanyId == company.id;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == state.companies.length - 1 ? 0 : 12.height,
              ),
              child: GestureDetector(
                onTap: () => context.read<RatePropertyCertifiedBloc>().add(
                  RatePropertyCertifiedCompanySelected(company.id),
                ),
                child: Container(
                  height: 120.height,
                  padding: EdgeInsets.all(16.width),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colors.primaryBrand.withValues(alpha: 0.05)
                        : colors.cardBackground,
                    borderRadius: BorderRadius.circular(12.radius),
                    border: Border.all(
                      color: isSelected
                          ? colors.primaryBrand
                          : colors.borderColor,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              company.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(16),
                                fontWeight: FontWeight.w700,
                                fontFamily: AppConstant.appHeaderFont,
                                color: colors.textFieldTitle,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.width,
                              vertical: 2.height,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primaryBrand.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.radius),
                            ),
                            child: Text(
                              AppStrings.ratePropertyCertifiedBadge,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(12),
                                color: colors.primaryBrand,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.height),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.rate,
                            size: 16.width,
                          ),

                          Text(
                            '${company.rating}',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textFieldTitle,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                          SizedBox(width: 4.width),

                          Text(
                            '(${company.reviewsCount}+ ${AppStrings.ratePropertyReviewsSuffix})',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.height),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12.width,
                            color: colors.primaryBrand,
                          ),
                          SizedBox(width: 8.width),

                          Expanded(
                            child: Text(
                              '${company.workDays} ${AppStrings.ratePropertyWorkDaysSuffix}',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(14),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ),
                          Text(
                            '${company.price.toInt()} ${AppStrings.currency}',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(16),
                              color: AppColors.secondBrand,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 32.height),
        ],
      ),
    );
  }
}
