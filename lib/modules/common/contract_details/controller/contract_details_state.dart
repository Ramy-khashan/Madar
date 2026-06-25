part of 'contract_details_bloc.dart';

class ContractDetailsState extends Equatable {
  const ContractDetailsState({
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
    this.contract,
  });

  final RequestStatus loadStatus;
  final String errorMsg;
  final ContractDetailsModel? contract;

  ContractDetailsState copyWith({
    RequestStatus? loadStatus,
    String? errorMsg,
    ContractDetailsModel? contract,
  }) {
    return ContractDetailsState(
      loadStatus: loadStatus ?? this.loadStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      contract: contract ?? this.contract,
    );
  }

  @override
  List<Object?> get props => [loadStatus, errorMsg, contract];
}
