import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.termsAndConditions),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.width,
          vertical: 12.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   AppStrings.termsLastUpdated,
            //   style: TextStyle(
            //     fontSize: context.responsiveFontScale(12),
            //     fontWeight: FontWeight.w400,
            //     color: tc.textSecondary,
            //   ),
            // ),
            // 12.height.toSizedBox,
            Text(
              AppStrings.termsIntro,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontWeight: FontWeight.w400,
                height: 1.6,
                color: tc.textPrimary,
              ),
            ),
            20.height.toSizedBox,
            ...AppStrings.termsSections.map(
              (section) => _TermsSection(
                title: section.title,
                body: section.body,
                tc: tc,
              ),
            ),
            24.height.toSizedBox,
          ],
        ),
      ),
    );
  }
}

class _TermsSection extends StatelessWidget {
  const _TermsSection({
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
