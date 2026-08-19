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
}class GetPropertyIdEvent extends ChooseBrokerEvent {
  final String propertyId;
  const GetPropertyIdEvent(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
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

class ChooseBrokerCommissionChanged extends ChooseBrokerEvent {
  const ChooseBrokerCommissionChanged(this.rate);
  final double rate;
  @override
  List<Object?> get props => [rate];
}

class ChooseBrokerPayerChanged extends ChooseBrokerEvent {
  const ChooseBrokerPayerChanged(this.payer);
  final String payer;
  @override
  List<Object?> get props => [payer];
}

class ChooseBrokerBack extends ChooseBrokerEvent {
  const ChooseBrokerBack();
}
