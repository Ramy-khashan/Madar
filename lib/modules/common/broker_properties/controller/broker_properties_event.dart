part of 'broker_properties_bloc.dart';

abstract class BrokerPropertiesEvent extends Equatable {
  const BrokerPropertiesEvent();

  @override
  List<Object?> get props => [];
}

class BrokerPropertiesLoad extends BrokerPropertiesEvent {
  const BrokerPropertiesLoad({
    this.brokerId = '',
    this.page = 1,
    this.isLoadMore = false,
  });

  final String brokerId;
  final int page;
  final bool isLoadMore;

  @override
  List<Object?> get props => [brokerId, page, isLoadMore];
}
