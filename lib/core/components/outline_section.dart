import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class OutlinedSection extends StatelessWidget {
  const OutlinedSection({
    super.key,
    required this.title,
    required this.child,
    this.titleFontSize = 16,
    this.imageUrl,
  });

  final String title;
  final String? imageUrl;
  final Widget child;
  final double titleFontSize;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (imageUrl != null) ...[ImageItem(imageUrl ?? ''),SizedBox(width: 8.width)],
              Expanded(
                child: Text(
                  title,
                   style: TextStyle(
                    fontSize: context.responsiveFontScale(titleFontSize),
                    fontWeight: FontWeight.w700,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.textFieldTitle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.height),
          child,
        ],
      ),
    );
  }
}
