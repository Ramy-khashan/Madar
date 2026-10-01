import 'package:flutter/material.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/components/confirm_delete_dialog.dart';
import '../../controller/financial_reports_bloc.dart';
import '../../model/financial_report_models.dart';
import 'shared/financial_property_row.dart';

class OtherIncomeCard extends StatelessWidget {
  const OtherIncomeCard({
    super.key,
    required this.colors,
    required this.items,
    required this.total,
    required this.isSubmitting,
    required this.onAdd,
  });

  final AppThemeColors colors;
  final List<FinancialRentItem> items;
  final double total;
  final bool isSubmitting;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.otherIncomeSources,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
              ),
              Text(
                AppStrings.totalAmountLabel(formatPrice(total)),
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  color: colors.textFieldTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.height),
          ...items.map(
            (item) => FinancialPropertyRow(
              date: item.date,
              status: item.status,
              name: item.name,
              amount: AppStrings.amountVal(item.amount),
              paid: item.paid,
              colors: colors,
              onDelete: item.id.isEmpty
                  ? null
                  : () => showConfirmDeleteDialog(
                      context: context,
                      title: AppStrings.confirmDelete,
                      content: AppStrings.deleteOtherIncomeConfirmation,
                      onConfirm: () => FinancialReportsBloc.get(
                        context,
                      ).add(FinancialReportsDeleteOtherIncome(item.id)),
                    ),
            ),
          ),
          SizedBox(height: 8.height),
          AppButton(
            text: AppStrings.addOtherIncome,
            textSize: 14,
            height: 44,
            isLoading: isSubmitting,
            onTap: onAdd,
          ),
        ],
      ),
    );
  }
}
