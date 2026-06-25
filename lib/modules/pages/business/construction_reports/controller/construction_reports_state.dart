part of 'construction_reports_bloc.dart';

class ConstructionReportsState extends Equatable {
  const ConstructionReportsState({
    this.selectedPeriod = 'monthly',
    this.selectedScope = 'all',
    this.selectedPropertyTypeIds = const [],
    this.occupancyRate = 0.5,
    this.activeContracts = 4,
    this.monthlyIncome = 120000,
    this.status = RequestStatus.init,
  });

  final String selectedPeriod;
  final String selectedScope;
  final List<String> selectedPropertyTypeIds;
  final double occupancyRate;
  final int activeContracts;
  final double monthlyIncome;
  final RequestStatus status;

  ConstructionReportsState copyWith({
    String? selectedPeriod,
    String? selectedScope,
    List<String>? selectedPropertyTypeIds,
    double? occupancyRate,
    int? activeContracts,
    double? monthlyIncome,
    RequestStatus? status,
  }) =>
      ConstructionReportsState(
        selectedPeriod: selectedPeriod ?? this.selectedPeriod,
        selectedScope: selectedScope ?? this.selectedScope,
        selectedPropertyTypeIds:
            selectedPropertyTypeIds ?? this.selectedPropertyTypeIds,
        occupancyRate: occupancyRate ?? this.occupancyRate,
        activeContracts: activeContracts ?? this.activeContracts,
        monthlyIncome: monthlyIncome ?? this.monthlyIncome,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
        selectedPeriod,
        selectedScope,
        selectedPropertyTypeIds,
        occupancyRate,
        activeContracts,
        monthlyIncome,
        status,
      ];
}
