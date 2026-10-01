import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../model/financial_report_models.dart';

class PartialPaymentCard extends StatelessWidget {
  const PartialPaymentCard({
    super.key,
    required this.colors,
    required this.rentItems,
  });

  final AppThemeColors colors;
  final List<FinancialRentItem> rentItems;

  @override
  Widget build(BuildContext context) {
    final partials = rentItems.where((i) => !i.paid).toList();
    if (partials.isEmpty) {
      return const SizedBox.shrink();
    }
    return OutlinedSection(
      title: AppStrings.partialPaymentsLabel,
      child: Container(
        padding: EdgeInsets.all(14.width),
        decoration: BoxDecoration(
          color: AppColors.rate.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12.radius),
          border: Border.all(color: AppColors.rate.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.height),
            ...partials.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 8.height),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          item.status ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            color: AppColors.rate,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.amountVal(item.amount),
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
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
      ),
    );
  }
}
