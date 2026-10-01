import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.height),
      child: Text(
        title,
        style: TextStyle(
          fontSize: context.responsiveFontScale(15),
          fontWeight: FontWeight.w700,
          color: AppThemeColors.of(context).textPrimary,
        ),
      ),
    );
  }
}
