part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  const ContractsState({
    this.contracts = const [],
    this.contractsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.isLoadMore = false,
    this.totalCount = 0,
    this.selectedFilter = 'ALL',
  });

  final List<ContractModel> contracts;
  final RequestStatus contractsStatus;
  final String errorMsg;
  final bool isLoadMore;
  final int totalCount;
  final String selectedFilter;

  ContractsState copyWith({
    List<ContractModel>? contracts,
    RequestStatus? contractsStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
    String? selectedFilter,
  }) {
    return ContractsState(
      contracts: contracts ?? this.contracts,
      contractsStatus: contractsStatus ?? this.contractsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object> get props => [
    contracts,
    contractsStatus,
    errorMsg,
    isLoadMore,
    totalCount,
    selectedFilter,
  ];
}
