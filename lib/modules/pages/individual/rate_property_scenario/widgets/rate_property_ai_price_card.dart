import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class RatePropertyAiPriceCard extends StatelessWidget {
  const RatePropertyAiPriceCard({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.periodDays,
    required this.dealsCount,
  });
  final double minValue;
  final double maxValue;
  final int periodDays;
  final int dealsCount;
  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Container(
      height: 170,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: tc.primaryBrand,
        gradient: LinearGradient(
          colors: [tc.primaryBrand, AppColors.darkSurface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          const PositionedDirectional(
            end: 0,

            bottom: 0,
            child: ImageItem(
              AppImages.splashBg,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome_rounded,
                      color: Color(0xFFFBBF24),
                      size: 14,
                    ),
                    SizedBox(width: 6.width),
                    Text(
                      AppStrings.aiSmartSuggestion,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(11),
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.height),
                Text(
                  AppStrings.suggestedPrice,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  formatPrice(minValue).toString() +
                      " - " +
                      formatPrice(maxValue).toString() +
                      " " +
                      AppStrings.currency,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(22),
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  "بناء على $dealsCount صفقة في النرجس اخر $periodDays يوم",
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
