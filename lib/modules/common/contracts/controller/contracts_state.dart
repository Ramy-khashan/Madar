part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  final List<ContractModel> allContracts;
  final String selectedFilter;

  const ContractsState({
      this.allContracts = const [],
      this.selectedFilter = 'all',
  });

  List<ContractModel> get filtered {
    switch (selectedFilter) {
      case 'all':
        return allContracts;
      case 'active':
        return allContracts
            .where((c) => c.status == 'active')
            .toList();
      case 'completed':
        return allContracts
            .where((c) => c.status == 'completed')
            .toList();
      default:
        return allContracts;
    }
  }

  int countFor(String tab) {
    switch (tab) {
      case 'all':
        return allContracts.length;
      case 'active':
        return allContracts
            .where((c) => c.status == 'active')
            .length;
      case 'completed':
        return allContracts
            .where((c) => c.status == 'completed')
            .length;
      default:
        return allContracts.length;
    }
  }

  ContractsState copyWith({
    List<ContractModel>? allContracts,
    String? selectedFilter,
  }) => ContractsState(
    allContracts: allContracts ?? this.allContracts,
    selectedFilter: selectedFilter ?? this.selectedFilter,
  );

  @override
  List<Object> get props => [allContracts, selectedFilter];
}
