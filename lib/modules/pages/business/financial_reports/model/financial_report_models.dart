import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FinancialPropertyItem extends Equatable {
  const FinancialPropertyItem({
    required this.name,
    required this.amount,
    required this.paid,
    this.status,
    this.date,
  });

  final String name;
  final String amount;
  final bool paid;
  final String? status;
  final DateTime? date;

  @override
  List<Object?> get props => [name, amount, paid, status, date];
}

class FinancialRentItem extends Equatable {
  const FinancialRentItem({
    required this.name,
    required this.amount,
    this.date,
    this.status,
    required this.paid,
  });

  final String name;
  final String amount;
  final DateTime? date;
  final String? status;
  final bool paid;

  @override
  List<Object?> get props => [name, amount, date, status, paid];
}

class FinancialTransaction extends Equatable {
  const FinancialTransaction({
    required this.name,
    required this.date,
    required this.desc,
    required this.amount,
    this.property = '',
    this.fileUrl = '',
  });

  final String name;
  final DateTime date;
  final String desc;
  final String amount;
  final String property;
  final String fileUrl;

  bool get hasFile => fileUrl.trim().isNotEmpty && fileUrl != 'null';

  @override
  List<Object?> get props => [name, date, desc, amount, property, fileUrl];
}

class FinancialTenant extends Equatable {
  const FinancialTenant({
    required this.name,
    required this.property,
    required this.amount,
    required this.days,
  });

  final String name;
  final String property;
  final String amount;
  final String days;

  @override
  List<Object?> get props => [name, property, amount, days];
}

class FinancialSettlement extends Equatable {
  const FinancialSettlement({
    required this.label,
    required this.date,
    required this.amount,
    required this.status,
  });

  final String label;
  final DateTime date;
  final String amount;
  final String status;

  bool get isCompleted => status == 'مكتملة';

  @override
  List<Object?> get props => [label, date, amount, status];
}

class DonutSectionData extends Equatable {
  const DonutSectionData({
    required this.label,
    required this.value,
    required this.colorValue,
  });

  final String label;
  final double value;
  final int colorValue;

  Color get color => Color(colorValue);

  @override
  List<Object?> get props => [label, value, colorValue];
}

class FinancialReportsResponse extends Equatable {
  const FinancialReportsResponse({
    required this.financialSummary,
    required this.expenseDistribution,
    required this.incomeDistribution,
    required this.incomeVsExpense,
    required this.transactionHistory,
    required this.topProperties,
  });

  final FinancialSummary financialSummary;
  final List<ExpenseDistributionItem> expenseDistribution;
  final List<IncomeDistributionItem> incomeDistribution;
  final List<IncomeVsExpenseItem> incomeVsExpense;
  final List<TransactionHistoryItem> transactionHistory;
  final List<TopPropertyIncomeItem> topProperties;

  factory FinancialReportsResponse.fromJson(Map<String, dynamic> json) {
    return FinancialReportsResponse(
      financialSummary: FinancialSummary.fromJson(
        Map<String, dynamic>.from(json['financialSummary'] ?? const {}),
      ),
      expenseDistribution: List<Map<String, dynamic>>.from(
        json['expenseDistribution'] ?? const [],
      ).map(ExpenseDistributionItem.fromJson).toList(),
      incomeDistribution: List<Map<String, dynamic>>.from(
        json['incomeDistribution'] ?? const [],
      ).map(IncomeDistributionItem.fromJson).toList(),
      incomeVsExpense: List<Map<String, dynamic>>.from(
        json['incomeVsExpense'] ?? const [],
      ).map(IncomeVsExpenseItem.fromJson).toList(),
      transactionHistory: List<Map<String, dynamic>>.from(
        json['transactionHistory'] ?? const [],
      ).map(TransactionHistoryItem.fromJson).toList(),
      topProperties: List<Map<String, dynamic>>.from(
        json['topProperties'] ?? const [],
      ).map(TopPropertyIncomeItem.fromJson).toList(),
    );
  }

  @override
  List<Object?> get props => [
    financialSummary,
    expenseDistribution,
    incomeDistribution,
    incomeVsExpense,
    transactionHistory,
    topProperties,
  ];
}

class FinancialSummary extends Equatable {
  const FinancialSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.netProfit,
  });

  final double totalIncome;
  final double totalExpenses;
  final double netProfit;

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      totalIncome: _asDouble(json['totalIncome']),
      totalExpenses: _asDouble(json['totalExpenses']),
      netProfit: _asDouble(json['netProfit']),
    );
  }

  @override
  List<Object?> get props => [totalIncome, totalExpenses, netProfit];
}

class ExpenseDistributionItem extends Equatable {
  const ExpenseDistributionItem({
    required this.type,
    required this.amount,
    required this.percentage,
  });

  final String type;
  final double amount;
  final double percentage;

  factory ExpenseDistributionItem.fromJson(Map<String, dynamic> json) {
    return ExpenseDistributionItem(
      type: (json['type'] ?? '').toString(),
      amount: _asDouble(json['amount']),
      percentage: _asDouble(json['percentage']),
    );
  }

  @override
  List<Object?> get props => [type, amount, percentage];
}

class IncomeDistributionItem extends Equatable {
  const IncomeDistributionItem({
    required this.source,
    required this.amount,
    required this.percentage,
  });

  final String source;
  final double amount;
  final double percentage;

  factory IncomeDistributionItem.fromJson(Map<String, dynamic> json) {
    return IncomeDistributionItem(
      source: (json['type'] ?? json['source'] ?? '').toString(),
      amount: _asDouble(json['amount']),
      percentage: _asDouble(json['percentage']),
    );
  }

  @override
  List<Object?> get props => [source, amount, percentage];
}

class IncomeVsExpenseItem extends Equatable {
  const IncomeVsExpenseItem({
    required this.month,
    required this.income,
    required this.expense,
  });

  final String month;
  final double income;
  final double expense;

  factory IncomeVsExpenseItem.fromJson(Map<String, dynamic> json) {
    return IncomeVsExpenseItem(
      month: (json['month'] ?? '').toString(),
      income: _asDouble(json['income']),
      expense: _asDouble(json['expense']),
    );
  }

  @override
  List<Object?> get props => [month, income, expense];
}

class TransactionHistoryItem extends Equatable {
  const TransactionHistoryItem({
    required this.amount,
    required this.type,
    required this.date,
    this.property = '',
    this.fileUrl = '',
  });

  final double amount;
  final String type;
  final DateTime date;
  final String property;
  final String fileUrl;

  factory TransactionHistoryItem.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryItem(
      amount: _asDouble(json['amount']),
      type: (json['type'] ?? '').toString(),
      date:
          DateTime.tryParse((json['date'] ?? '').toString()) ?? DateTime.now(),
      property: (json['property'] ?? '').toString(),
      fileUrl: (json['file'] ?? json['fileUrl'] ?? '').toString(),
    );
  }

  @override
  List<Object?> get props => [amount, type, date, property, fileUrl];
}

class TopPropertyIncomeItem extends Equatable {
  const TopPropertyIncomeItem({
    required this.propertyId,
    required this.property,
    required this.income,
  });

  final String propertyId;
  final String property;
  final double income;

  factory TopPropertyIncomeItem.fromJson(Map<String, dynamic> json) {
    return TopPropertyIncomeItem(
      propertyId: (json['propertyId'] ?? '').toString(),
      property: (json['property'] ?? '').toString(),
      income: _asDouble(json['income']),
    );
  }

  @override
  List<Object?> get props => [propertyId, property, income];
}

double _asDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }
  return double.tryParse(value?.toString() ?? '') ?? 0;
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map) return Map<String, dynamic>.from(value);
  return const {};
}

List<Map<String, dynamic>> _asMapList(dynamic value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
}

class DashboardRevenueItem extends Equatable {
  const DashboardRevenueItem({
    this.contractId = '',
    this.property = '',
    this.type = '',
    this.amount = 0,
    this.date,
    this.status = '',
  });

  final String contractId;
  final String property;
  final String type;
  final double amount;
  final DateTime? date;
  final String status;

  bool get isActive => status.toUpperCase() == 'ACTIVE';

  factory DashboardRevenueItem.fromJson(Map<String, dynamic> json) {
    return DashboardRevenueItem(
      contractId: (json['contractId'] ?? json['id'] ?? '').toString(),
      property: (json['property'] ?? json['propertyTitle'] ?? json['title'] ?? '')
          .toString(),
      type: (json['type'] ?? '').toString(),
      amount: _asDouble(json['amount']),
      date: DateTime.tryParse((json['date'] ?? '').toString()),
      status: (json['status'] ?? '').toString(),
    );
  }

  @override
  List<Object?> get props => [contractId, property, type, amount, date, status];
}

class DashboardRevenuesResponse extends Equatable {
  const DashboardRevenuesResponse({
    this.totalIncome = 0,
    this.rentalsTotal = 0,
    this.otherTotal = 0,
    this.otherIncomeTotal = 0,
    this.rentals = const [],
    this.otherTransactions = const [],
    this.otherIncome = const [],
  });

  final double totalIncome;
  final double rentalsTotal;
  final double otherTotal;
  final double otherIncomeTotal;
  final List<DashboardRevenueItem> rentals;
  final List<DashboardRevenueItem> otherTransactions;
  final List<DashboardRevenueItem> otherIncome;

  factory DashboardRevenuesResponse.fromJson(Map<String, dynamic> json) {
    final rentals = _asMap(json['rentals']);
    final others = _asMap(json['otherTransactions']);
    final otherIncome = _asMap(json['otherIncome']);
    return DashboardRevenuesResponse(
      totalIncome: _asDouble(json['totalIncome']),
      rentalsTotal: _asDouble(rentals['total']),
      otherTotal: _asDouble(others['total']),
      otherIncomeTotal: _asDouble(otherIncome['total']),
      rentals: _asMapList(
        rentals['items'],
      ).map(DashboardRevenueItem.fromJson).toList(),
      otherTransactions: _asMapList(
        others['items'],
      ).map(DashboardRevenueItem.fromJson).toList(),
      otherIncome: _asMapList(
        otherIncome['items'],
      ).map(DashboardRevenueItem.fromJson).toList(),
    );
  }

  @override
  List<Object?> get props => [
    totalIncome,
    rentalsTotal,
    otherTotal,
    otherIncomeTotal,
    rentals,
    otherTransactions,
    otherIncome,
  ];
}

class DashboardExpensesResponse extends Equatable {
  const DashboardExpensesResponse({
    this.totalExpenses = 0,
    this.distribution = const [],
    this.transactions = const [],
  });

  final double totalExpenses;
  final List<ExpenseDistributionItem> distribution;
  final List<TransactionHistoryItem> transactions;

  factory DashboardExpensesResponse.fromJson(Map<String, dynamic> json) {
    return DashboardExpensesResponse(
      totalExpenses: _asDouble(json['totalExpenses']),
      distribution: _asMapList(
        json['expenseDistribution'],
      ).map(ExpenseDistributionItem.fromJson).toList(),
      transactions: _asMapList(
        json['transactions'] ?? json['transactionHistory'],
      ).map(TransactionHistoryItem.fromJson).toList(),
    );
  }

  @override
  List<Object?> get props => [totalExpenses, distribution, transactions];
}
