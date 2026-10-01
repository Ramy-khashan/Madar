import 'package:flutter/material.dart';

import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import 'insight_card.dart';

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
            InsightCard(
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
