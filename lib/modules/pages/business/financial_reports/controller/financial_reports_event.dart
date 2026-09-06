part of 'financial_reports_bloc.dart';

sealed class FinancialReportsEvent extends Equatable {
  const FinancialReportsEvent();

  @override
  List<Object?> get props => [];
}

final class FinancialReportsLoad extends FinancialReportsEvent {
  const FinancialReportsLoad();
}

final class FinancialReportsTabChanged extends FinancialReportsEvent {
  final int tabIndex;
  const FinancialReportsTabChanged(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

final class FinancialReportsPeriodChanged extends FinancialReportsEvent {
  final String period;
  const FinancialReportsPeriodChanged(this.period);

  @override
  List<Object?> get props => [period];
}

final class FinancialReportsScopeChanged extends FinancialReportsEvent {
  final String scope;
  const FinancialReportsScopeChanged(this.scope);

  @override
  List<Object?> get props => [scope];
}

final class FinancialReportsAddOtherIncome extends FinancialReportsEvent {
  const FinancialReportsAddOtherIncome({
    required this.title,
    required this.amount,
  });

  final String title;
  final num amount;

  @override
  List<Object?> get props => [title, amount];
}
