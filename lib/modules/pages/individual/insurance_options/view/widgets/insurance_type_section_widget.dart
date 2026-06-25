import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/insurance_options_model.dart';

class InsuranceTypeCard extends StatelessWidget {
  const InsuranceTypeCard({
    super.key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final InsuranceTypeModel type;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primaryBrand.withValues(alpha: 0.05)
              : colors.cardBackground,
          borderRadius: BorderRadius.circular(16.radius),
          border: Border.all(
            color: isSelected ? colors.primaryBrand : colors.borderColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      type.name,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(14),
                        fontWeight: FontWeight.w700,
                        color: colors.textFieldTitle,
                        fontFamily: AppConstant.appHeaderFont,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${formatPrice(type.pricePerYear)} ${AppStrings.perYearSuffix}',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    color: colors.primaryBrand,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.height),
            Center(
              child: Wrap(
                spacing: 6.width,
                runSpacing: 6.height,
                children: type.coverages
                    .map(
                      (c) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.width,
                          vertical: 4.height,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primaryBrand.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(20.radius),
                        ),
                        child: Text(
                          c,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(12),
                            color: colors.textFieldTitle,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppConstant.appFont,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
