import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/financial_reports_bloc.dart';
import 'add_other_income_dialog.dart';
import 'shared/financial_property_row.dart';
import 'revenue_section.dart';
import 'partial_payment_card.dart';
import 'other_income_card.dart';

class FinancialReportsRevenueTabWidget extends StatelessWidget {
  const FinancialReportsRevenueTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<FinancialReportsBloc, FinancialReportsState>(
      buildWhen: (p, c) =>
          p.rentItems != c.rentItems ||
          p.otherIncomeItems != c.otherIncomeItems ||
          p.rentalTotal != c.rentalTotal ||
          p.otherIncomeTotal != c.otherIncomeTotal ||
          p.totalIncome != c.totalIncome ||
          p.isSubmittingOtherIncome != c.isSubmittingOtherIncome,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(16.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RevenueSection(
                title: AppStrings.paidRentsLabel,
                trailing: AppStrings.totalAmountLabel(
                  formatPrice(state.rentalTotal),
                ),
                colors: colors,
                child: Column(
                  children: state.rentItems
                      .map(
                        (item) => FinancialPropertyRow(
                          date: item.date,
                          status: item.status,
                          name: item.name,
                          amount: AppStrings.amountVal(item.amount),
                          paid: item.paid,
                          colors: colors,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 12.height),
              PartialPaymentCard(colors: colors, rentItems: state.rentItems),
              SizedBox(height: 12.height),
              OtherIncomeCard(
                colors: colors,
                items: state.otherIncomeItems,
                total: state.otherIncomeTotal,
                isSubmitting: state.isSubmittingOtherIncome,
                onAdd: () => showAddOtherIncomeDialog(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
