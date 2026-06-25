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
  });

  final List<BrokerModel> brokers;
  final String searchQuery;
  final String? selectedBrokerId;
  final ChooseBrokerStep step;
  final RequestStatus loadStatus;
  final RequestStatus confirmStatus;
  final String errorMsg;

  List<BrokerModel> get filteredBrokers {
    if (searchQuery.isEmpty) return brokers;
    return brokers
        .where((b) =>
            b.name.contains(searchQuery) || b.location.contains(searchQuery))
        .toList();
  }

  BrokerModel? get selectedBroker =>
      selectedBrokerId == null
          ? null
          : brokers.where((b) => b.id == selectedBrokerId).firstOrNull;

  @override
  List<Object?> get props => [
        brokers, searchQuery, selectedBrokerId, step,
        loadStatus, confirmStatus, errorMsg,
      ];

  ChooseBrokerState copyWith({
    List<BrokerModel>? brokers,
    String? searchQuery,
    String? selectedBrokerId,
    bool clearSelectedBrokerId = false,
    ChooseBrokerStep? step,
    RequestStatus? loadStatus,
    RequestStatus? confirmStatus,
    String? errorMsg,
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
    );
  }
}
