import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/functions/responsive.dart';
 

class PerformanceSummaryShape extends StatelessWidget {
  const PerformanceSummaryShape({
    super.key,
    required this.title,
    required this.image,
    required this.value,
  });
  final String title;
  final String image;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.height,
      padding: EdgeInsets.all(8.width),
      decoration: BoxDecoration(
        color: AppThemeColors.of(context).primaryBrand.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: AppThemeColors.of(context).primaryBrand),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                height: 32.width,
                width: 32.width,
                padding: EdgeInsets.all(8.width),
                decoration: BoxDecoration(
                  color: AppThemeColors.of(
                    context,
                  ).primaryBrand ,
                  borderRadius: BorderRadius.circular(4.width),
                ),
                child: ImageItem(image,color: AppThemeColors.of(context).onPrimary),
              ),
              SizedBox(width: 8.width),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.bold,
                    color: AppThemeColors.of(context).textFieldTitle,
                  ),
                ),
              ),
            ],
          ),
           Padding(
            padding: EdgeInsets.only(top: 8.height),
            child: Text(value,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(18),
                  fontWeight: FontWeight.bold,
                  color: AppThemeColors.of(context).primaryBrand,
                )),
          ),
        ],
      ),
    );
  }
}
