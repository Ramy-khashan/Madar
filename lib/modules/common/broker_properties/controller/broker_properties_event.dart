part of 'broker_properties_bloc.dart';

abstract class BrokerPropertiesEvent extends Equatable {
  const BrokerPropertiesEvent();

  @override
  List<Object?> get props => [];
}

class BrokerPropertiesLoad extends BrokerPropertiesEvent {
  const BrokerPropertiesLoad();
}

class BrokerPropertiesFilterApplied extends BrokerPropertiesEvent {
  const BrokerPropertiesFilterApplied(this.filter);
  final PropertyFilterModel filter;
  @override
  List<Object?> get props => [filter];
}
