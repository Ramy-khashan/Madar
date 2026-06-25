import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class InfoCardItem extends StatelessWidget {
  const InfoCardItem({super.key, required this.title, this.iconImage});
  final String title;
  final String? iconImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: AppColors.rate.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: AppColors.rate.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (iconImage != null) ...[
            ImageItem(
              iconImage!,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.brownColor
                  : AppColors.rate,
            ),
            SizedBox(width: 8.width),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.brownColor
                    : AppColors.rate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
