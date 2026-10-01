import 'package:flutter/material.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/utils/functions/responsive.dart';

class TermsSection extends StatelessWidget {
  const TermsSection({
    super.key,
    required this.title,
    required this.body,
    required this.tc,
  });

  final String title;
  final String body;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.responsiveFontScale(15),
              fontWeight: FontWeight.w700,
              color: tc.primaryBrand,
            ),
          ),
          8.height.toSizedBox,
          Text(
            body,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontWeight: FontWeight.w400,
              height: 1.7,
              color: tc.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
