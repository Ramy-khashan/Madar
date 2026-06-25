import 'package:flutter/material.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class NetProfitLossNotesWidget extends StatelessWidget {
  const NetProfitLossNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return OutlinedSection(
      title: AppStrings.analyticalInsights,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _InsightCard(
            emoji: '💡',
            message: 'أداء مالي قوي هذا الشهر بزيادة ٢٠٪ في صافي الربح',
            bgColor: AppColors.backgroundLight,
            borderColor: AppColors.secondBrand.withValues(alpha: 0.2),
            textColor: colors.textPrimary,
          ),
          SizedBox(height: 8.height),
          _InsightCard(
            emoji: '⚠️',
            message: 'انتبه: المصروفات زادت ٧٪ - راجع بنود الصيانة',
            bgColor: AppColors.rate.withValues(alpha: 0.08),
            borderColor: AppColors.rate.withValues(alpha: 0.3),
            textColor: AppColors.brownColor,
          ),
          SizedBox(height: 8.height),
          _InsightCard(
            emoji: '✅',
            message: 'نسبة التحصيل ممتازة: ٩٧٪ من الإيجارات المستحقة',
            bgColor: AppColors.successColor.withValues(alpha: 0.06),
            borderColor: AppColors.successColor.withValues(alpha: 0.25),
            textColor: AppColors.successColor,
          ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.emoji,
    required this.message,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
  });

  final String emoji;
  final String message;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.radius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: context.responsiveFontScale(16)),
          ),
          SizedBox(width: 8.width),

          Expanded(
            child: Text(
              message,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: textColor,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
