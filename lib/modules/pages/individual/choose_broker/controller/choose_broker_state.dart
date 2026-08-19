part of 'choose_broker_bloc.dart';

enum ChooseBrokerStep { list, details }

class ChooseBrokerState extends Equatable {
  const ChooseBrokerState({
    this.brokers = const [],
    this.searchQuery = '',
    this.selectedBrokerId,
    this.step = ChooseBrokerStep.list,
    this.loadStatus = RequestStatus.init,
    this.confirmStatus = RequestStatus.init,
    this.errorMsg = '',
    this.propertyId = '',
    this.isLoadMore = false,
    this.totalCount = 0,
    this.commissionRate = 2,
    this.commissionPayer = 'OWNER',
  });

  final List<BrokerModel> brokers;
  final String searchQuery;
  final String? selectedBrokerId;
  final ChooseBrokerStep step;
  final RequestStatus loadStatus;
  final RequestStatus confirmStatus;
  final String errorMsg;
  final String propertyId;
  final bool isLoadMore;
  final int totalCount;
  final double commissionRate;
  final String commissionPayer;

  List<BrokerModel> get filteredBrokers {
    if (searchQuery.isEmpty) return brokers;
    return brokers
        .where(
          (b) =>
              b.name.contains(searchQuery) || b.location.contains(searchQuery),
        )
        .toList();
  }

  BrokerModel? get selectedBroker => selectedBrokerId == null
      ? null
      : brokers.where((b) => b.userId == selectedBrokerId).firstOrNull;

  @override
  List<Object?> get props => [
    brokers,
    searchQuery,
    selectedBrokerId,
    step,
    loadStatus,
    confirmStatus,
    errorMsg,
    isLoadMore,
    totalCount,
    propertyId,
    commissionRate,
    commissionPayer,
  ];

  ChooseBrokerState copyWith({
    List<BrokerModel>? brokers,
    String? propertyId,
    String? searchQuery,
    String? selectedBrokerId,
    bool clearSelectedBrokerId = false,
    ChooseBrokerStep? step,
    RequestStatus? loadStatus,
    RequestStatus? confirmStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
    double? commissionRate,
    String? commissionPayer,
  }) {
    return ChooseBrokerState(
      brokers: brokers ?? this.brokers,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedBrokerId: clearSelectedBrokerId
          ? null
          : selectedBrokerId ?? this.selectedBrokerId,
      step: step ?? this.step,
      loadStatus: loadStatus ?? this.loadStatus,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
      propertyId: propertyId ?? this.propertyId,
      commissionRate: commissionRate ?? this.commissionRate,
      commissionPayer: commissionPayer ?? this.commissionPayer,
    );
  }
}
