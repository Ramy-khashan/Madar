import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AddApartmentCard extends StatelessWidget {
  const AddApartmentCard({super.key, required this.colors, required this.onTap});

  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(12.radius),
          border: Border.all(color: colors.primaryBrand.withValues(alpha: 0.45)),
        ),
        padding: EdgeInsets.all(8.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32.width,
              height: 32.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.primaryBrand.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.radius),
              ),
              child: Icon(
                Icons.add_rounded,
                color: colors.primaryBrand,
                size: 22.width,
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              AppStrings.addApartment,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w700,
                color: colors.primaryBrand,
                fontFamily: AppConstant.appHeaderFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
