import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import 'terms_section.dart';

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
              (section) => TermsSection(
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
