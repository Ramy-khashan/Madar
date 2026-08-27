part of 'contracts_bloc.dart';

class ContractsState extends Equatable {
  const ContractsState({
    this.contracts = const [],
    this.contractsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.isLoadMore = false,
    this.totalCount = 0,
    this.hasNext = false,
    this.counts = const {},
    this.selectedFilter = 'ALL',
  });

  final List<ContractModel> contracts;
  final RequestStatus contractsStatus;
  final String errorMsg;
  final bool isLoadMore;
  final int totalCount;
  final bool hasNext;
  final Map<String, int> counts;
  final String selectedFilter;

  ContractsState copyWith({
    List<ContractModel>? contracts,
    RequestStatus? contractsStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
    bool? hasNext,
    Map<String, int>? counts,
    String? selectedFilter,
  }) {
    return ContractsState(
      contracts: contracts ?? this.contracts,
      contractsStatus: contractsStatus ?? this.contractsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
      hasNext: hasNext ?? this.hasNext,
      counts: counts ?? this.counts,
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
    hasNext,
    counts,
    selectedFilter,
  ];
}
