import 'package:flutter/material.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/image_item.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/functions/responsive.dart';

class BusinessSubscriptionItem extends StatelessWidget {
  const BusinessSubscriptionItem({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.height),
        padding: EdgeInsets.symmetric(
          horizontal: 14.width,
          vertical: 12.height,
        ),
        decoration: BoxDecoration(
          color: AppThemeColors.of(
            context,
          ).primaryBrand.withValues(alpha: 0.15),
          border: Border.all(color: AppThemeColors.of(context).primaryBrand),
          borderRadius: BorderRadius.circular(16.radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(end: 12.width),
              padding: EdgeInsets.all(12.width),

              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: AppThemeColors.of(context).primaryBrand,
                borderRadius: BorderRadius.circular(8.radius),
              ),
              child: ImageItem(
                AppImages.chatbotIcon,
                width: 38.width,
                height: 38.width,
                color: AppThemeColors.of(context).onPrimary,
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "الباقة الاحترافية",
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w700,
                            color: AppThemeColors.of(context).primaryBrand,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16.width,
                        color: AppThemeColors.of(context).primaryBrand,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.height),
                  Text(
                    "صالحة حتى 6 يونيو 2026",
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      fontWeight: FontWeight.w500,
                      color: AppThemeColors.of(context).textFieldTitle,
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
