part of 'construction_reports_bloc.dart';

class ConstructionReportsState extends Equatable {
  const ConstructionReportsState({
    this.selectedPeriod = 'monthly',
    this.selectedScope = 'all',
    this.selectedPropertyTypeIds = const [],
    this.report = const PerformanceReportModel(),
    this.status = RequestStatus.init,
    this.errorMessage = '',
  });

  final String selectedPeriod;
  final String selectedScope;
  final List<String> selectedPropertyTypeIds;
  final PerformanceReportModel report;
  final RequestStatus status;
  final String errorMessage;

  int get activeContracts => report.activeContracts.count;
  double get occupancyRate => report.occupancyRate;
  double get monthlyIncome => report.monthlyIncome;

  ConstructionReportsState copyWith({
    String? selectedPeriod,
    String? selectedScope,
    List<String>? selectedPropertyTypeIds,
    PerformanceReportModel? report,
    RequestStatus? status,
    String? errorMessage,
  }) => ConstructionReportsState(
    selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    selectedScope: selectedScope ?? this.selectedScope,
    selectedPropertyTypeIds:
        selectedPropertyTypeIds ?? this.selectedPropertyTypeIds,
    report: report ?? this.report,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    selectedPeriod,
    selectedScope,
    selectedPropertyTypeIds,
    report,
    status,
    errorMessage,
  ];
}
