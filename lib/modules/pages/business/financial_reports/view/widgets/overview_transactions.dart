import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../model/financial_report_models.dart';

class OverviewTransactions extends StatelessWidget {
  const OverviewTransactions({
    super.key,
    required this.colors,
    required this.items,
  });

  final AppThemeColors colors;
  final List<FinancialTransaction> items;

  @override
  Widget build(BuildContext context) {
    final visible = items.length > 12 ? items.take(12).toList() : items;
    return OutlinedSection(
      title: AppStrings.transactionDetails,
      child: Column(
        children: [
          for (final item in visible)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.height),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy').format(item.date),
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(11),
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${item.amount} ${AppStrings.currency}',
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(13),
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
