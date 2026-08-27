import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AiGenerateButton extends StatelessWidget {
  const AiGenerateButton({super.key, required this.onTap, required this.tc});
  final VoidCallback onTap;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerEnd,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.auto_awesome_rounded, color: tc.primaryBrand, size: 14),
            SizedBox(width: 6.width),
            Text(
              AppStrings.generateWithAi,
              style: TextStyle(
                fontSize: context.responsiveFontScale(13),
                fontWeight: FontWeight.w600,
                color: tc.primaryBrand,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
