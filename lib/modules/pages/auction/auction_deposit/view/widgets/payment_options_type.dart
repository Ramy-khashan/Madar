import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class PaymentOptionCard extends StatelessWidget {
  const PaymentOptionCard({
    super.key,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final String icon;
  final AuctionDepositPaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: EdgeInsets.only(bottom: 12.height),
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 14.height,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ?colors.primaryBrand.withValues(alpha: 0.1)
              : colors.cardBackground,
          borderRadius: BorderRadius.circular(14.radius),
          border: Border.all(
            color: isSelected ? colors.primaryBrand : colors.textFieldBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.radius),
              ),
              child: ImageItem(
                icon,
                width: 32.width,
                height: 32.width,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            SizedBox(width: 12.width),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(16),
                      fontFamily: AppConstant.appHeaderFont,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 2.height),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontFamily: AppConstant.appFont,
                      color: colors.textSecondary,
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
