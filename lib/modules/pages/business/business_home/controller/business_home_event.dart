part of 'business_home_bloc.dart';

sealed class BusinessHomeEvent extends Equatable {
  const BusinessHomeEvent();

  @override
  List<Object> get props => [];
}
class BusinessHomeItemsEvent extends BusinessHomeEvent {
  const BusinessHomeItemsEvent();
}

class BusinessPropertiesLoad extends BusinessHomeEvent {
  const BusinessPropertiesLoad();
}

class PortfolioLoad extends BusinessHomeEvent {
  const PortfolioLoad();
}
final class IndividualHomeLoadUserLocation extends BusinessHomeEvent {
  const IndividualHomeLoadUserLocation();
}

class RequestsLoad extends BusinessHomeEvent {
  const RequestsLoad();
}
