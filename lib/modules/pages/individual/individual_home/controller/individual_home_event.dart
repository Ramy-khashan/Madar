part of 'individual_home_bloc.dart';

sealed class IndividualHomeEvent extends Equatable {
  const IndividualHomeEvent();

  @override
  List<Object> get props => [];
}

final class IndividualHomeLoad extends IndividualHomeEvent {
  const IndividualHomeLoad();
}
class IndividualHomeLoadProperties extends IndividualHomeEvent {
  const IndividualHomeLoadProperties();
}
class IndividualHomeLoadPortfolio extends IndividualHomeEvent {
  const IndividualHomeLoadPortfolio();
}
final class IndividualHomeLoadAds extends IndividualHomeEvent {
  const IndividualHomeLoadAds();
}final class IndividualHomeLoadUserLocation extends IndividualHomeEvent {
  const IndividualHomeLoadUserLocation();
}