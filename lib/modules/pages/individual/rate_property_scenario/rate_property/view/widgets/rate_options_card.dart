
import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class RateOptionCard extends StatelessWidget {
  const RateOptionCard({super.key, 
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.subtitle,
    required this.timeSuffix,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  final String title;
  final String badge;
  final Color badgeColor;
  final String subtitle;
  final String timeSuffix;
  final String icon;
  final AppThemeColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.width),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(12.radius),
          border: Border.all(color: colors.borderColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.width),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryBrand.withValues(alpha: 0.1),
              ),
              child: ImageItem(icon, color: colors.primaryBrand),
            ),
            SizedBox(width: 12.width),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(16),
                            fontWeight: FontWeight.w700,
                            fontFamily: AppConstant.appHeaderFont,
                            color: colors.textFieldTitle,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.width,
                              vertical: 2.height,
                            ),
                            decoration: BoxDecoration(
                              color: badgeColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.radius),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 6.width,
                                  height: 6.width,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: badgeColor,
                                  ),
                                ),
                                SizedBox(width: 4.width),
                                Text(
                                  badge,
                                  style: TextStyle(
                                    fontSize: context.responsiveFontScale(12),
                                    color: badgeColor,
                                    fontFamily: AppConstant.appFont,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 12.width),

                  SizedBox(height: 6.height),
                  Text(
                    subtitle,
                     style: TextStyle(
                      fontSize: context.responsiveFontScale(14),
                      color: colors.textSecondary,
                      fontFamily: AppConstant.appFont,
                    ),
                  ),
                  SizedBox(height: 4.height),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12.width,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.width),

                      Text(
                        timeSuffix,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(12),
                          color: colors.textSecondary,
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
