import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../model/financial_report_models.dart';

class LateTenantsCard extends StatelessWidget {
  const LateTenantsCard({
    super.key,
    required this.colors,
    required this.tenants,
  });

  final AppThemeColors colors;
  final List<FinancialTenant> tenants;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: AppColors.rate.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: AppColors.rate.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.latePaymentsLabel} (${tenants.length})',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 10.height),
          ...tenants.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: 8.height),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.name,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: colors.textPrimary,
                        ),
                      ),
                      Text(
                        t.property,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${t.amount} ${AppStrings.currency}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          fontWeight: FontWeight.w600,
                          color: AppColors.brownColor,
                        ),
                      ),
                      Text(
                        t.days,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(11),
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
