import 'package:equatable/equatable.dart';

class ProfitLossComparisonItem extends Equatable {
  const ProfitLossComparisonItem({this.amount = 0, this.percent = 0});

  final double amount;
  final double percent;

  factory ProfitLossComparisonItem.fromJson(Map<String, dynamic> json) {
    return ProfitLossComparisonItem(
      amount: _asDouble(json['amount']),
      percent: _asDouble(json['percent']),
    );
  }

  @override
  List<Object?> get props => [amount, percent];
}

class ProfitLossModel extends Equatable {
  const ProfitLossModel({
    this.totalIncome = 0,
    this.totalExpenses = 0,
    this.netProfit = 0,
    this.incomeComparison = const ProfitLossComparisonItem(),
    this.expensesComparison = const ProfitLossComparisonItem(),
    this.netProfitComparison = const ProfitLossComparisonItem(),
    this.insights = const [],
  });

  final double totalIncome;
  final double totalExpenses;
  final double netProfit;
  final ProfitLossComparisonItem incomeComparison;
  final ProfitLossComparisonItem expensesComparison;
  final ProfitLossComparisonItem netProfitComparison;
  final List<String> insights;

  factory ProfitLossModel.fromJson(Map<String, dynamic> json) {
    final comparison = json['comparison'] is Map
        ? Map<String, dynamic>.from(json['comparison'] as Map)
        : const <String, dynamic>{};
    return ProfitLossModel(
      totalIncome: _asDouble(json['totalIncome']),
      totalExpenses: _asDouble(json['totalExpenses']),
      netProfit: _asDouble(json['netProfit']),
      incomeComparison: ProfitLossComparisonItem.fromJson(
        _asMap(comparison['income']),
      ),
      expensesComparison: ProfitLossComparisonItem.fromJson(
        _asMap(comparison['expenses']),
      ),
      netProfitComparison: ProfitLossComparisonItem.fromJson(
        _asMap(comparison['netProfit']),
      ),
      insights: (json['insights'] is List)
          ? List.from(json['insights'] as List)
                .map((e) => e.toString().trim())
                .where((e) => e.isNotEmpty)
                .toList()
          : const [],
    );
  }

  @override
  List<Object?> get props => [
    totalIncome,
    totalExpenses,
    netProfit,
    incomeComparison,
    expensesComparison,
    netProfitComparison,
    insights,
  ];
}

double _asDouble(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  return const {};
}
