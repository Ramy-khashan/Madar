import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/rent_options_model.dart';

class ProviderTilePart extends StatelessWidget {
  const ProviderTilePart({
    required this.provider,
    required this.isSelected,
    required this.isLast,
    required this.onTap,
    super.key,
  });

  final InstallmentProviderModel provider;
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
                border: Border.all(color:isSelected
                    ? colors.primaryBrand 
                    : colors.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    provider.name,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w700,
                      color: colors.textFieldTitle,
                      fontFamily: AppConstant.appHeaderFont,
                    ),
                  ),
                  SizedBox(height: 8.height),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12.width,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.width),
                      Text(
                        '${provider.processingHours} ${AppStrings.processingHoursLabel}',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: colors.textSecondary,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.star, size: 14.width, color: AppColors.rate),
                      SizedBox(width: 4.width),
                      Text(
                        provider.rating.toString(),
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appFont,
                        ),
                      ),
                    ],
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
