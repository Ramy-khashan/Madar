part of 'individual_home_bloc.dart';

class IndividualHomeState extends Equatable {
  final List<PropertyModel> properties;
  final List<PortfolioPropertyModel> portfolio;
  final String userLocation;

  const IndividualHomeState({
    this.properties = const [],
    this.portfolio = const [],
    this.userLocation = '',
  });

  @override
  List<Object> get props => [properties, portfolio, userLocation];
  IndividualHomeState copyWith({
    List<PropertyModel>? properties,
    List<PortfolioPropertyModel>? portfolio,
    String? userLocation,
  }) {
    return IndividualHomeState(
      properties: properties ?? this.properties,
      portfolio: portfolio ?? this.portfolio,
      userLocation: userLocation ?? this.userLocation,
    );
  }
}
