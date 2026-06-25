part of 'business_home_bloc.dart';

  class BusinessHomeState extends Equatable {
  const BusinessHomeState({
    this.requests = const [],
    this.portfolio = const [],
    this.properties = const [],
    this.location = '',
  });
final List<PropertyModel>properties;
final List<PortfolioPropertyModel>portfolio;
final List<BusinessPropertyRequestModel>requests;
final String location;
  @override
  List<Object> get props => [portfolio, requests,properties, location];
  BusinessHomeState copyWith({
    List<PropertyModel>? properties,
    List<PortfolioPropertyModel>? portfolio,
    List<BusinessPropertyRequestModel>? requests,
    String? location,
  }) {
    return BusinessHomeState(
      portfolio: portfolio ?? this.portfolio,
      location: location ?? this.location,
      requests: requests ?? this.requests,  
      properties: properties ?? this.properties,
    );
  }
}
 