part of 'contracts_bloc.dart';

sealed class ContractsEvent extends Equatable {
  const ContractsEvent();

  @override
  List<Object> get props => [];
}

final class ContractsLoad extends ContractsEvent {
  const ContractsLoad();
}

final class ContractsFilterChanged extends ContractsEvent {
  final String filter;
  const ContractsFilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}
