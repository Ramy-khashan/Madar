part of 'contract_details_bloc.dart';

class ContractDetailsState extends Equatable {
  const ContractDetailsState({
    this.loadStatus = RequestStatus.init,
    this.actionStatus = RequestStatus.init,
    this.errorMsg = '',
    this.actionMessage = '',
    this.contractId = '',
    this.shouldPop = false,
    this.contract,
  });

  final RequestStatus loadStatus;
  final RequestStatus actionStatus;
  final String errorMsg;
  final String actionMessage;
  final String contractId;
  final bool shouldPop;
  final ContractDetailsModel? contract;

  ContractDetailsState copyWith({
    RequestStatus? loadStatus,
    RequestStatus? actionStatus,
    String? errorMsg,
    String? actionMessage,
    String? contractId,
    bool? shouldPop,
    ContractDetailsModel? contract,
  }) {
    return ContractDetailsState(
      loadStatus: loadStatus ?? this.loadStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      actionMessage: actionMessage ?? this.actionMessage,
      contractId: contractId ?? this.contractId,
      shouldPop: shouldPop ?? this.shouldPop,
      contract: contract ?? this.contract,
    );
  }

  @override
  List<Object?> get props => [
    loadStatus,
    actionStatus,
    errorMsg,
    actionMessage,
    contractId,
    shouldPop,
    contract,
  ];
}
