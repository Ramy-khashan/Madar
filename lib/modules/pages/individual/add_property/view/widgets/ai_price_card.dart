import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AiPriceCard extends StatelessWidget {
  const AiPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Container(
      height: 170,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: tc.primaryBrand,
      gradient: LinearGradient(
        colors: [
          tc.primaryBrand,
          AppColors.darkSurface,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),),
      child: Stack(
        children: [
          PositionedDirectional(
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
                      'اقتراح ذكي - مدار AI',
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
                  'السعر المقترح',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '2.6 - 1.3 مليون',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(22),
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  'بناء على 47 صفقة في النرجس اخر 90 يوم',
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
