import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../controller/financial_reports_bloc.dart';
import '../../model/financial_report_models.dart';
import 'shared/financial_status_badge.dart';

/// Tab content for التسويات (Settlements) tab.
class FinancialReportsSettlementsTabWidget extends StatelessWidget {
  const FinancialReportsSettlementsTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<FinancialReportsBloc, FinancialReportsState>(
      buildWhen: (p, c) => p.settlements != c.settlements,
      builder: (context, state) {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppStrings.financialTabSettlements,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(15),
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
              SizedBox(height: 12.height),
              ...state.settlements.map(
                (item) => _SettlementCard(settlement: item, colors: colors),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettlementCard extends StatelessWidget {
  const _SettlementCard({required this.settlement, required this.colors});

  final FinancialSettlement settlement;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.height),
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(10.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  settlement.label,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.height),
                Text(
                  DateFormat('dd-MM-yyyy').format(settlement.date),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(11),
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.width),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                settlement.amount,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  fontWeight: FontWeight.w700,
                  color: colors.primaryBrand,
                ),
              ),
              SizedBox(height: 4.height),
              FinancialStatusBadge(
                label: settlement.status,
                isCompleted: settlement.isCompleted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
