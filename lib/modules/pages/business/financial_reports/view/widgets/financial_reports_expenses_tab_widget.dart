import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/components/outline_section.dart';
import '../../../../../../../config/router/app_router_keys.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/components/app_button.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/common_fun.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/financial_reports_bloc.dart';
import 'shared/financial_property_row.dart';

class FinancialReportsExpensesTabWidget extends StatelessWidget {
  const FinancialReportsExpensesTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<FinancialReportsBloc, FinancialReportsState>(
      buildWhen: (p, c) =>
          p.categoryItems != c.categoryItems ||
          p.transactions != c.transactions,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // حسب الفئة
              Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.byCategory,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(14),
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                        ),
                        Text(
                          AppStrings.amountVal(
                            formatPrice(state.totalExpenses),
                          ),
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.height),
                    ...state.categoryItems.map(
                      (item) => FinancialPropertyRow(
                        name: item.name,
                        amount: item.amount,
                        status: item.status,
                        date: item.date,
                        paid: item.paid,
                        colors: colors,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.height),
              // تفاصيل المعاملات
              OutlinedSection(
                title: AppStrings.transactionDetails,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: state.transactions
                      .map(
                        (t) => Container(
                          padding: EdgeInsets.symmetric(vertical: 10.height),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colors.borderColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(13),
                                      color: colors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(t.date),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(11),
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    t.desc,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: context.responsiveFontScale(11),
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${t.amount} ${AppStrings.currency}',
                                style: TextStyle(
                                  fontSize: context.responsiveFontScale(13),
                                  fontWeight: FontWeight.w600,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 20.height),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  onTap: () {
                    RouterHandler.navigate(
                      context,
                      AppRouterKeys.netProfitLossScreen,
                    );
                  },
                  text: AppStrings.netProfitLossTitle,
                ),
              ),
              SizedBox(height: 16.height),
            ],
          ),
        );
      },
    );
  }
}
