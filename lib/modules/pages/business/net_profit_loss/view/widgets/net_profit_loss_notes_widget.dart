import 'package:flutter/material.dart';

import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class NetProfitLossNotesWidget extends StatelessWidget {
  const NetProfitLossNotesWidget({super.key, required this.insights});

  final List<String> insights;

  @override
  Widget build(BuildContext context) {
    if (insights.isEmpty) return const SizedBox.shrink();
    final colors = AppThemeColors.of(context);
    return OutlinedSection(
      title: AppStrings.analyticalInsights,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < insights.length; i++) ...[
            if (i > 0) SizedBox(height: 8.height),
            _InsightCard(
              message: insights[i],
              bgColor: i == 0
                  ? AppColors.backgroundLight
                  : AppColors.successColor.withValues(alpha: 0.06),
              borderColor: i == 0
                  ? AppColors.secondBrand.withValues(alpha: 0.2)
                  : AppColors.successColor.withValues(alpha: 0.25),
              textColor: i == 0 ? colors.textPrimary : AppColors.successColor,
            ),
          ],
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.message,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
  });

  final String message;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.radius),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        message,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: context.responsiveFontScale(14),
          color: textColor,
          height: 1.5,
        ),
      ),
    );
  }
}
