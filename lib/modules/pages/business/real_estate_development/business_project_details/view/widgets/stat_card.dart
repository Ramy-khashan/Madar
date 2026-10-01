import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/image_item.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/constants/app_images.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.count,
    required this.colors,
  });

  final String label;
  final int count;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.width, vertical: 8.height),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15.width,
                backgroundColor: colors.primaryBrand.withValues(alpha: 0.08),
                child: ImageItem(
                  AppImages.occupancyRateIcon,
                  color: colors.primaryBrand,
                ),
              ),
              SizedBox(width: 4.width),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: colors.textFieldTitle,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.height),
          Center(
            child: Text(
              '$count',
              style: TextStyle(
                fontSize: context.responsiveFontScale(20),
                fontWeight: FontWeight.w800,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.primaryBrand,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
