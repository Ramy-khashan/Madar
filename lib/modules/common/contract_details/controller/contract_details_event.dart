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
