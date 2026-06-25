import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/insurance_options_model.dart';

class CompanyTile extends StatelessWidget {
  const CompanyTile({
    required this.company,
    required this.isSelected,
    required this.isLast,
    required this.onTap,
    super.key,
  });

  final InsuranceCompanyModel company;
  final bool isSelected;
  final bool isLast;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.height),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.width,
                vertical: 14.height,
              ),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16.radius),
                border: Border.all(color: isSelected
                    ? colors.primaryBrand 
                    : colors.borderColor),
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12.width,
                            color: colors.primaryBrand,
                          ),
                          SizedBox(width: 4.width),
                          Text(
                            '${company.processingHours} ${AppStrings.processingHoursLabel}',
                            style: TextStyle(
                              fontSize: context.responsiveFontScale(14),
                              color: colors.textSecondary,
                              fontFamily: AppConstant.appFont,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        company.rating.toString(),
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Icon(
                          Icons.star,
                          size: 16.width,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${AppStrings.discountPrefix} ${company.discountPercent}%',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: AppColors.secondBrand,
                      fontFamily: AppConstant.appFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
