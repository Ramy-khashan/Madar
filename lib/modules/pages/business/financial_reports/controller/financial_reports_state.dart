part of 'financial_reports_bloc.dart';

class FinancialReportsState extends Equatable {
  static const _noValue = Object();

  const FinancialReportsState({
    this.selectedTab = 0,
    this.selectedPeriod = 'monthly',
    this.selectedScope = 'all',
    this.totalIncome = 0,
    this.netProfit = 0,
    this.totalExpenses = 0,
    this.lateRent = 0,
    this.errorMessage,
    this.status = RequestStatus.init,
    this.categoryItems = const [],
    this.transactions = const [],
    this.rentItems = const [],
    this.incomeDistribution = const [],
    this.incomeVsExpense = const [],
    this.lateTenants = const [],
    this.settlements = const [],
    this.incomeSections = const [],
    this.expensesSections = const [],
  });

  /// 0 = نظرة عامة, 1 = الايرادات, 2 = المصروفات
  final int selectedTab;
  final String selectedPeriod;
  final String selectedScope;
  final double totalIncome;
  final double netProfit;
  final double totalExpenses;
  final double lateRent;
  final String? errorMessage;
  final RequestStatus status;

  // Data lists
  final List<FinancialPropertyItem> categoryItems;
  final List<FinancialTransaction> transactions;
  final List<FinancialRentItem> rentItems;
  final List<IncomeDistributionItem> incomeDistribution;
  final List<IncomeVsExpenseItem> incomeVsExpense;
  final List<FinancialTenant> lateTenants;
  final List<FinancialSettlement> settlements;
  final List<StatisticCircleModel> incomeSections;
  final List<StatisticCircleModel> expensesSections;

  FinancialReportsState copyWith({
    int? selectedTab,
    String? selectedPeriod,
    String? selectedScope,
    double? totalIncome,
    double? netProfit,
    double? totalExpenses,
    double? lateRent,
    Object? errorMessage = _noValue,
    RequestStatus? status,
    List<FinancialPropertyItem>? categoryItems,
    List<FinancialTransaction>? transactions,
    List<FinancialRentItem>? rentItems,
    List<IncomeDistributionItem>? incomeDistribution,
    List<IncomeVsExpenseItem>? incomeVsExpense,
    List<FinancialTenant>? lateTenants,
    List<FinancialSettlement>? settlements,
    List<StatisticCircleModel>? incomeSections,
    List<StatisticCircleModel>? expensesSections,
  }) => FinancialReportsState(
    selectedTab: selectedTab ?? this.selectedTab,
    selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    selectedScope: selectedScope ?? this.selectedScope,
    totalIncome: totalIncome ?? this.totalIncome,
    netProfit: netProfit ?? this.netProfit,
    totalExpenses: totalExpenses ?? this.totalExpenses,
    lateRent: lateRent ?? this.lateRent,
    errorMessage: identical(errorMessage, _noValue)
        ? this.errorMessage
        : errorMessage as String?,
    status: status ?? this.status,
    categoryItems: categoryItems ?? this.categoryItems,
    transactions: transactions ?? this.transactions,
    rentItems: rentItems ?? this.rentItems,
    incomeDistribution: incomeDistribution ?? this.incomeDistribution,
    incomeVsExpense: incomeVsExpense ?? this.incomeVsExpense,
    lateTenants: lateTenants ?? this.lateTenants,
    settlements: settlements ?? this.settlements,
    incomeSections: incomeSections ?? this.incomeSections,
    expensesSections: expensesSections ?? this.expensesSections,
  );

  @override
  List<Object?> get props => [
    selectedTab,
    selectedPeriod,
    selectedScope,
    totalIncome,
    netProfit,
    totalExpenses,
    lateRent,
    errorMessage,
    status,
    categoryItems,
    transactions,
    rentItems,
    incomeDistribution,
    incomeVsExpense,
    lateTenants,
    settlements,
    incomeSections,
    expensesSections,
  ];
}
