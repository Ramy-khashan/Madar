part of 'broker_properties_bloc.dart';

abstract class BrokerPropertiesState extends Equatable {
  const BrokerPropertiesState();

  @override
  List<Object?> get props => [];
}

class BrokerPropertiesInitial extends BrokerPropertiesState {}

class BrokerPropertiesLoaded extends BrokerPropertiesState {
  const BrokerPropertiesLoaded({
    required this.broker,
    required this.properties,
    this.filter = const PropertyFilterModel(),
  });

  final PropertyListingUserModel broker;
  final List<PropertyModel> properties;
  final PropertyFilterModel filter;

  @override
  List<Object?> get props => [broker, properties, filter];
}
