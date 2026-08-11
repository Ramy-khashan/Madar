import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/model/statistic_circle_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../model/financial_report_models.dart';

part 'financial_reports_event.dart';
part 'financial_reports_state.dart';

class FinancialReportsBloc
    extends Bloc<FinancialReportsEvent, FinancialReportsState> {
  FinancialReportsBloc() : super(const FinancialReportsState()) {
    on<FinancialReportsLoad>(_onLoad);
    on<FinancialReportsTabChanged>(_onTabChanged);
    on<FinancialReportsPeriodChanged>(_onPeriodChanged);
    on<FinancialReportsScopeChanged>(_onScopeChanged);
  }

  static FinancialReportsBloc get(BuildContext context) =>
      context.read<FinancialReportsBloc>();

  static const List<Color> _incomePalette = [
    Color(0xFF6C63FF),
    Color(0xFFFF6B9D),
    Color(0xFF26C6DA),
    Color(0xFFB39DDB),
    Color(0xFF81C784),
  ];

  static const List<Color> _expensePalette = [
    Color(0xFFFF7043),
    Color(0xFFAB47BC),
    Color(0xFF5C6BC0),
    Color(0xFF26A69A),
    Color(0xFFFBC02D),
  ];

  Future<void> _onLoad(
    FinancialReportsLoad event,
    Emitter<FinancialReportsState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await sl.get<ApiConsumer>().get(
      EndPoints.financialReports,
      queryParameters: {'period': state.selectedPeriod},
    );

    await response.fold(
      (failure) async {
        emit(
          state.copyWith(status: RequestStatus.failed, errorMessage: failure),
        );
      },
      (success) async {
        final payload = Map<String, dynamic>.from(
          success.response['data'] ?? {},
        );
        final report = FinancialReportsResponse.fromJson(payload);

        emit(
          state.copyWith(
            status: RequestStatus.success,
            errorMessage: null,
            totalIncome: report.financialSummary.totalIncome,
            totalExpenses: report.financialSummary.totalExpenses,
            netProfit: report.financialSummary.netProfit,
            lateRent: 0,
            categoryItems: report.expenseDistribution
                .map(
                  (item) => FinancialPropertyItem(
                    name: item.type,
                    amount: formatPrice(item.amount),
                    paid: true,
                    status: '${item.percentage.toStringAsFixed(2)}%',
                  ),
                )
                .toList(),
            transactions: report.transactionHistory
                .map(
                  (item) => FinancialTransaction(
                    name: item.type,
                    date: item.date,
                    desc: item.amount >= 0 ? AppStrings.transactionTypeIncome : AppStrings.transactionTypeExpense,
                    amount:
                        '${item.amount >= 0 ? '+' : '-'}${formatPrice(item.amount.abs())}',
                  ),
                )
                .toList(),
            rentItems: report.topProperties
                .map(
                  (item) => FinancialRentItem(
                    name: item.property,
                    amount: formatPrice(item.income),
                    paid: true,
                  ),
                )
                .toList(),
            incomeDistribution: report.incomeDistribution,
            incomeVsExpense: report.incomeVsExpense,
            lateTenants: const [],
            settlements: const [],
            incomeSections: _buildIncomeSections(report.incomeDistribution),
            expensesSections: _buildExpenseSections(report.expenseDistribution),
          ),
        );
      },
    );
  }

  void _onTabChanged(
    FinancialReportsTabChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tabIndex));
  }

  void _onPeriodChanged(
    FinancialReportsPeriodChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(selectedPeriod: event.period));
    add(const FinancialReportsLoad());
  }

  void _onScopeChanged(
    FinancialReportsScopeChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    emit(state.copyWith(selectedScope: event.scope));
  }

  List<StatisticCircleModel> _buildIncomeSections(
    List<IncomeDistributionItem> items,
  ) {
    return items.asMap().entries.map((entry) {
      final value =
          (entry.value.percentage > 1
                  ? entry.value.percentage / 100
                  : entry.value.percentage)
              .clamp(0.0, 1.0);
      return StatisticCircleModel(
        label: entry.value.source,
        value: value.toDouble(),
        color: _incomePalette[entry.key % _incomePalette.length],
      );
    }).toList();
  }

  List<StatisticCircleModel> _buildExpenseSections(
    List<ExpenseDistributionItem> items,
  ) {
    return items.asMap().entries.map((entry) {
      final value =
          (entry.value.percentage > 1
                  ? entry.value.percentage / 100
                  : entry.value.percentage)
              .clamp(0.0, 1.0);
      return StatisticCircleModel(
        label: entry.value.type,
        value: value.toDouble(),
        color: _expensePalette[entry.key % _expensePalette.length],
      );
    }).toList();
  }
}
