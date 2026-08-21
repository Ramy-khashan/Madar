part of 'net_profit_loss_bloc.dart';

class NetProfitLossState extends Equatable {
  const NetProfitLossState({
    this.netProfit = 0,
    this.totalIncome = 0,
    this.totalExpenses = 0,
    this.incomeComparison = const ProfitLossComparisonItem(),
    this.expensesComparison = const ProfitLossComparisonItem(),
    this.netProfitComparison = const ProfitLossComparisonItem(),
    this.insights = const [],
    this.status = RequestStatus.init,
    this.exportStatus = RequestStatus.init,
    this.errorMessage = '',
  });

  final double netProfit;
  final double totalIncome;
  final double totalExpenses;
  final ProfitLossComparisonItem incomeComparison;
  final ProfitLossComparisonItem expensesComparison;
  final ProfitLossComparisonItem netProfitComparison;
  final List<String> insights;
  final RequestStatus status;
  final RequestStatus exportStatus;
  final String errorMessage;

  NetProfitLossState copyWith({
    double? netProfit,
    double? totalIncome,
    double? totalExpenses,
    ProfitLossComparisonItem? incomeComparison,
    ProfitLossComparisonItem? expensesComparison,
    ProfitLossComparisonItem? netProfitComparison,
    List<String>? insights,
    RequestStatus? status,
    RequestStatus? exportStatus,
    String? errorMessage,
  }) => NetProfitLossState(
    netProfit: netProfit ?? this.netProfit,
    totalIncome: totalIncome ?? this.totalIncome,
    totalExpenses: totalExpenses ?? this.totalExpenses,
    incomeComparison: incomeComparison ?? this.incomeComparison,
    expensesComparison: expensesComparison ?? this.expensesComparison,
    netProfitComparison: netProfitComparison ?? this.netProfitComparison,
    insights: insights ?? this.insights,
    status: status ?? this.status,
    exportStatus: exportStatus ?? this.exportStatus,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    netProfit,
    totalIncome,
    totalExpenses,
    incomeComparison,
    expensesComparison,
    netProfitComparison,
    insights,
    status,
    exportStatus,
    errorMessage,
  ];
}
