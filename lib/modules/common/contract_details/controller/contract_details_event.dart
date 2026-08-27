part of 'contract_details_bloc.dart';

abstract class ContractDetailsEvent extends Equatable {
  const ContractDetailsEvent();

  @override
  List<Object?> get props => [];
}

class ContractDetailsLoad extends ContractDetailsEvent {
  const ContractDetailsLoad(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

class ContractDetailsApprove extends ContractDetailsEvent {
  const ContractDetailsApprove({
    required this.durationInYears,
    required this.finalPrice,
  });

  final String durationInYears;
  final num finalPrice;

  @override
  List<Object?> get props => [durationInYears, finalPrice];
}

class ContractDetailsReject extends ContractDetailsEvent {
  const ContractDetailsReject();
}

class ContractDetailsRenew extends ContractDetailsEvent {
  const ContractDetailsRenew();
}
