import 'package:flutter/material.dart';
import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/property_details/model/property_details_model.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/common_fun.dart';
import '../utils/functions/responsive.dart';

class PortfolioFinancialStats extends StatelessWidget {
  const PortfolioFinancialStats({super.key, required this.performance});

  final FinancialPerformance performance;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Row(
          children: [
            _stat(
              context,
              colors,
              AppStrings.totalUnits,
              '${performance.totalChildUnits ?? 0}',
            ),
            SizedBox(width: 8.width),
            _stat(
              context,
              colors,
              AppStrings.activeUnits,
              '${performance.activeChildUnits ?? 0}',
            ),
          ],
        ),
        SizedBox(height: 8.height),
        Row(
          children: [
            _stat(
              context,
              colors,
              AppStrings.occupancyRate,
              performance.occupancyRateLabel,
            ),
            SizedBox(width: 8.width),
            _stat(
              context,
              colors,
              AppStrings.yearlyIncome,
              '${formatPrice(performance.totalIncome?.toDouble() ?? 0)} ${AppStrings.currency}',
            ),
          ],
        ),
      ],
    );
  }

  Widget _stat(
    BuildContext context,
    AppThemeColors colors,
    String label,
    String value,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.width, vertical: 8.height),
        decoration: BoxDecoration(
          color: colors.primaryBrand.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.radius),
        ),
        child: Column(
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(10),
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: 2.height),
            Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.responsiveFontScale(12),
                fontWeight: FontWeight.w700,
                color: colors.textFieldTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
