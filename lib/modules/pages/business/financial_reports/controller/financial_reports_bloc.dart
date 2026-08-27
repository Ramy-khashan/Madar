import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/statistic_circle_model.dart';
import '../../../../../core/repository/apis/dashboard_apis.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/translation.dart';
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
    emit(state.copyWith(status: RequestStatus.loading, errorMessage: null));
    switch (state.selectedTab) {
      case 1:
        await _loadRevenues(emit);
      case 2:
        await _loadExpenses(emit);
      default:
        await _loadOverview(emit);
    }
  }

  Future<void> _loadOverview(Emitter<FinancialReportsState> emit) async {
    final result = await DashboardApis.overview(
      period: state.selectedPeriod,
      scope: state.selectedScope,
    );
    result.fold(
      (err) =>
          emit(state.copyWith(status: RequestStatus.failed, errorMessage: err)),
      (payload) {
        final report = FinancialReportsResponse.fromJson(payload);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            errorMessage: null,
            totalIncome: report.financialSummary.totalIncome,
            totalExpenses: report.financialSummary.totalExpenses,
            netProfit: report.financialSummary.netProfit,
            incomeDistribution: report.incomeDistribution,
            incomeVsExpense: report.incomeVsExpense,
            incomeSections: _buildIncomeSections(report.incomeDistribution),
            expensesSections: _buildExpenseSections(report.expenseDistribution),
          ),
        );
      },
    );
  }

  Future<void> _loadRevenues(Emitter<FinancialReportsState> emit) async {
    final result = await DashboardApis.revenues(
      period: state.selectedPeriod,
      scope: state.selectedScope,
    );
    result.fold(
      (err) =>
          emit(state.copyWith(status: RequestStatus.failed, errorMessage: err)),
      (payload) {
        final report = DashboardRevenuesResponse.fromJson(payload);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            errorMessage: null,
            totalIncome: report.totalIncome,
            rentalTotal: report.rentalsTotal,
            otherIncomeTotal: report.otherTotal,
            rentItems: report.rentals.map(_rentItemFromRevenue).toList(),
            otherIncomeItems: report.otherTransactions
                .map(_rentItemFromRevenue)
                .toList(),
          ),
        );
      },
    );
  }

  Future<void> _loadExpenses(Emitter<FinancialReportsState> emit) async {
    final result = await DashboardApis.expenses(
      period: state.selectedPeriod,
      scope: state.selectedScope,
    );
    result.fold(
      (err) =>
          emit(state.copyWith(status: RequestStatus.failed, errorMessage: err)),
      (payload) {
        final report = DashboardExpensesResponse.fromJson(payload);
        emit(
          state.copyWith(
            status: RequestStatus.success,
            errorMessage: null,
            totalExpenses: report.totalExpenses,
            categoryItems: report.distribution
                .map(
                  (item) => FinancialPropertyItem(
                    name: item.type.transIfExists,
                    amount: formatPrice(item.amount),
                    paid: true,
                    status: '${item.percentage.toStringAsFixed(2)}%',
                  ),
                )
                .toList(),
            transactions: report.transactions.map(_transactionFromApi).toList(),
            expensesSections: _buildExpenseSections(report.distribution),
          ),
        );
      },
    );
  }

  FinancialRentItem _rentItemFromRevenue(DashboardRevenueItem item) {
    return FinancialRentItem(
      name: item.property,
      amount: formatPrice(item.amount),
      date: item.date,
      status: item.type.isNotEmpty
          ? item.type.transIfExists
          : item.status.transIfExists,
      paid: item.isActive,
    );
  }

  FinancialTransaction _transactionFromApi(TransactionHistoryItem item) {
    final isIncome = item.amount >= 0;
    return FinancialTransaction(
      name: item.type.transIfExists,
      date: item.date,
      desc: item.property.isNotEmpty
          ? item.property
          : (isIncome
                ? AppStrings.transactionTypeIncome
                : AppStrings.transactionTypeExpense),
      amount: '${isIncome ? '+' : '-'}${formatPrice(item.amount.abs())}',
      property: item.property,
      fileUrl: item.fileUrl,
    );
  }

  void _onTabChanged(
    FinancialReportsTabChanged event,
    Emitter<FinancialReportsState> emit,
  ) {
    if (event.tabIndex == state.selectedTab) return;
    emit(state.copyWith(selectedTab: event.tabIndex));
    add(const FinancialReportsLoad());
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
    add(const FinancialReportsLoad());
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
        label: entry.value.source.transIfExists,
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
        label: entry.value.type.transIfExists,
        value: value.toDouble(),
        color: _expensePalette[entry.key % _expensePalette.length],
      );
    }).toList();
  }
}
