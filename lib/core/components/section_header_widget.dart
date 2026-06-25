import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget({super.key, required this.title, this.onViewAll, this.trailing});

  final String title;
  final Widget? trailing;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: context.responsiveHorizontalPadding,
        right: context.responsiveHorizontalPadding,
        bottom: 12.height,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: context.responsiveFontScale(16),
                fontWeight: FontWeight.w500,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textFieldTitle,
              ),
            ),
          ),
          onViewAll != null
              ? GestureDetector(
                  onTap: onViewAll,
                  child: Text(
                    AppStrings.viewAll,
                    style: TextStyle(
                      color: colors.primaryBrand,
                      fontSize: context.responsiveFontScale(12),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
              trailing ?? SizedBox(width: 8.width),
        ],
      ),
    );
  }
}
