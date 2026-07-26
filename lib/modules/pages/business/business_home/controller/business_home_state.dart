part of 'business_home_bloc.dart';

class BusinessHomeState extends Equatable {
  const BusinessHomeState({
    this.requests = const [],
    this.portfolio = const [],
    this.properties = const [],
    this.performanceSummary = const [],
    this.businessPropertiesLoadStatus = RequestStatus.init,
    this.portfolioLoadStatus = RequestStatus.init,
    this.requestsLoadStatus = RequestStatus.init,
    this.propertiesErrorMessage = '',
    this.portfolioErrorMessage = '',
    this.requestsErrorMessage = '',
    this.location = '',
  });
  final List<PropertiesItemModel> properties;
  final List<PortfolioPropertyModel> portfolio;
  final List<BusinessPropertyRequestModel> requests;
  final RequestStatus businessPropertiesLoadStatus;
  final RequestStatus portfolioLoadStatus;
  final RequestStatus requestsLoadStatus;
  final String propertiesErrorMessage;
  final String portfolioErrorMessage;
  final String requestsErrorMessage;

  final String location;
  final List<SmartServiceModel> performanceSummary;

  @override
  List<Object> get props => [
    portfolio,
    requests,
    properties,
    location,
    businessPropertiesLoadStatus,
    portfolioLoadStatus,
    requestsLoadStatus,
    propertiesErrorMessage,
    portfolioErrorMessage,
    requestsErrorMessage,
    performanceSummary,
    
  ];
  BusinessHomeState copyWith({
    List<PropertiesItemModel>? properties,
    List<PortfolioPropertyModel>? portfolio,
    List<BusinessPropertyRequestModel>? requests,
    List<SmartServiceModel>? performanceSummary,
    RequestStatus? businessPropertiesLoadStatus,
    RequestStatus? portfolioLoadStatus,
    RequestStatus? requestsLoadStatus,
    String? propertiesErrorMessage,
    String? portfolioErrorMessage,
    String? requestsErrorMessage,
    String? location,
  }) {
    return BusinessHomeState(
      portfolio: portfolio ?? this.portfolio,
      location: location ?? this.location,
      requests: requests ?? this.requests,
      properties: properties ?? this.properties,
      businessPropertiesLoadStatus:
          businessPropertiesLoadStatus ?? this.businessPropertiesLoadStatus,
      portfolioLoadStatus: portfolioLoadStatus ?? this.portfolioLoadStatus,
      requestsLoadStatus: requestsLoadStatus ?? this.requestsLoadStatus,
      propertiesErrorMessage:
          propertiesErrorMessage ?? this.propertiesErrorMessage,
      portfolioErrorMessage:
          portfolioErrorMessage ?? this.portfolioErrorMessage,
      requestsErrorMessage: requestsErrorMessage ?? this.requestsErrorMessage,
      performanceSummary: performanceSummary ?? this.performanceSummary,
    );
  }
}
