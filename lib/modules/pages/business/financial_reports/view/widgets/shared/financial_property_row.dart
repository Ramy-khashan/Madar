import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

/// A row showing a property name + amount with a colored status dot.
/// Shared between expenses category list and revenue rent items.
class FinancialPropertyRow extends StatelessWidget {
  const FinancialPropertyRow({
    super.key,
    required this.name,
    required this.amount,
    required this.paid,
    this.status,
    this.date,
    required this.colors,
  });

  final String name;
  final String amount;
  final DateTime? date;
  final String? status;
  final bool paid;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.height),
      padding: EdgeInsets.symmetric(vertical: 14.height, horizontal: 12.width),
      decoration: BoxDecoration(
        color: colors.textFieldBorder.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24.radius),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(16),

                          fontWeight: FontWeight.w600,
                          color: colors.textFieldTitle,
                        ),
                      ),
                    ),
                    Text(
                      amount,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: context.responsiveFontScale(16),
                        fontWeight: FontWeight.w600,
                        color: colors.textFieldTitle,
                      ),
                    ),
                  ],
                ),
                if (status != null || date != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          status ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      Text(
                        date == null
                            ? ''
                            : DateFormat('dd-MM-yyyy').format(date!),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(13),
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Container(
            width: 8.width,
            height: 8.width,
            margin: EdgeInsetsDirectional.only(start: 8.width),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: paid ? AppColors.successColor : AppColors.rate,
            ),
          ),
        ],
      ),
    );
  }
}
