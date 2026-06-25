import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/property_insurance_model.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer, required this.colors});

  final InsuranceOfferModel offer;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  offer.companyName,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(18),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.width,
                  vertical: 4.height,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.radius),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 13.width,
                      color: AppColors.successColor,
                    ),
                    SizedBox(width: 4.width),
                    Text(
                      AppStrings.certifiedBadge,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        color: AppColors.successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
           Padding(
             padding: EdgeInsets.symmetric(vertical: 12.height),
             child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    AppStrings.insuranceTypeFieldLabel,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 4.width),
                Text(
                  offer.insuranceTypeText,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: colors.textFieldTitle,
                  ),
                ),
              ],
                       ),
           ),

           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.coverageLabel,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textSecondary,
                ),
              ),
              SizedBox(width: 4.width),
              Expanded(
                child: Text(
                  offer.coverageDescription,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: colors.textFieldTitle,
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 30.height),
          Text(
            '${AppStrings.pricesStartingFrom} ${offer.startingPrice} ${AppStrings.perYearSuffixSar}',
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: colors.primaryBrand,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
