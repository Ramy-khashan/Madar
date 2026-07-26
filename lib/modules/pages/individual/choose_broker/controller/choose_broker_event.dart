part of 'choose_broker_bloc.dart';

abstract class ChooseBrokerEvent extends Equatable {
  const ChooseBrokerEvent();

  @override
  List<Object?> get props => [];
}

class ChooseBrokerLoad extends ChooseBrokerEvent {
  const ChooseBrokerLoad({this.page = 1, this.isLoadMore = false});

  final int page;
  final bool isLoadMore;

  @override
  List<Object?> get props => [page, isLoadMore];
}

class ChooseBrokerSearch extends ChooseBrokerEvent {
  final String query;
  const ChooseBrokerSearch(this.query);

  @override
  List<Object?> get props => [query];
}

class ChooseBrokerSelect extends ChooseBrokerEvent {
  final String brokerId;
  const ChooseBrokerSelect(this.brokerId);

  @override
  List<Object?> get props => [brokerId];
}

class ChooseBrokerConfirm extends ChooseBrokerEvent {
  const ChooseBrokerConfirm();
}

class ChooseBrokerBack extends ChooseBrokerEvent {
  const ChooseBrokerBack();
}
