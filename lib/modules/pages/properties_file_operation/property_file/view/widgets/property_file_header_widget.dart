import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';

class PropertyFileHeaderWidget extends StatelessWidget {
  const PropertyFileHeaderWidget({
    super.key,
    required this.property,
    required this.colors,
    required this.onBookmarkTap,
  });

  final PropertyFileModel property;
  final AppThemeColors colors;
  final VoidCallback onBookmarkTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Hero image with overlay badges
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.radius),
              child: ImageItem(
                property.imageUrl,
                width: double.infinity,
                height: 200.height,
                fit: BoxFit.cover,
              ),
            ),
            // Bookmark
            Positioned(
              top: 12.height,
              left: 12.width,
              child: GestureDetector(
                onTap: onBookmarkTap,
                child: Container(
                  padding: EdgeInsets.all(8.width),
                  decoration: BoxDecoration(
                    color: colors.cardBackground,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Icon(
                    property.isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: colors.primaryBrand,
                    size: 20.width,
                  ),
                ),
              ),
            ),
            // Property type tag
            Positioned(
              top: 12.height,
              right: 12.width,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.width,
                  vertical: 4.height,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryBrand,
                  borderRadius: BorderRadius.circular(20.radius),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_outlined,
                        color: colors.onPrimary, size: 14.width),
                    SizedBox(width: 4.width),
                    Text(
                      property.propertyType,
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: context.responsiveFontScale(12),
                        fontFamily: AppConstant.appFont,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.height),
        // Name
        Text(
          property.name,
          style: TextStyle(
            fontSize: context.responsiveFontScale(20),
            fontWeight: FontWeight.w700,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appHeaderFont,
          ),
        ),
        SizedBox(height: 4.height),
        // Location
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              property.location,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                color: colors.textSecondary,
                fontFamily: AppConstant.appFont,
              ),
            ),
            SizedBox(width: 4.width),
            Icon(Icons.location_on_outlined,
                size: 16.width, color: colors.textSecondary),
          ],
        ),
        SizedBox(height: 16.height),
        // Stats row
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.home_outlined,
                value: '${property.totalUnits}',
                label: 'الشقق',
                colors: colors,
              ),
            ),
            SizedBox(width: 8.width),
            Expanded(
              child: _StatCard(
                icon: Icons.bar_chart,
                value: '${property.occupancyRate}%',
                label: 'نسبة الاشغال',
                colors: colors,
              ),
            ),
            SizedBox(width: 8.width),
            Expanded(
              child: _StatCard(
                icon: Icons.description_outlined,
                value: _formatRevenue(property.monthlyRevenue),
                label: 'الإيراد الشهري',
                colors: colors,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatRevenue(double val) {
    if (val >= 1000) return '${(val / 1000).toStringAsFixed(1)}K';
    return val.toStringAsFixed(0);
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final String value;
  final String label;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.height, horizontal: 8.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(16.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: colors.primaryBrand, size: 24.width),
          SizedBox(height: 4.height),
          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(16),
              fontWeight: FontWeight.w700,
              color: colors.textFieldTitle,
              fontFamily: AppConstant.appHeaderFont,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: context.responsiveFontScale(11),
              color: colors.textSecondary,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ],
      ),
    );
  }
}
