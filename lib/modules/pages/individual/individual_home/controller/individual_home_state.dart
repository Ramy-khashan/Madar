part of 'individual_home_bloc.dart';

class IndividualHomeState extends Equatable {
  final List<PropertiesItemModel> properties;
  final List<PortfolioPropertyModel> portfolio;
  final List<AdsItemModel> adsItem;
  final String propertiesErrorMsg;
  final String portfolioErrorMsg;
  final String adsErrorMsg;
  final RequestStatus propertiesStatus;
  final RequestStatus portfolioStatus;
  final RequestStatus adsStatus;
  final String userLocation;

  const IndividualHomeState({
    this.properties = const [],
    this.portfolio = const [],
    this.adsItem = const [],
    this.propertiesErrorMsg = '',
    this.portfolioErrorMsg = '',
    this.adsErrorMsg = '',
    this.propertiesStatus = RequestStatus.init,
    this.portfolioStatus = RequestStatus.init,
    this.adsStatus = RequestStatus.init,
    this.userLocation = '',
  });

  @override
  List<Object> get props => [properties, portfolio, adsItem, userLocation, propertiesErrorMsg, portfolioErrorMsg, adsErrorMsg, propertiesStatus, portfolioStatus, adsStatus];
  IndividualHomeState copyWith({
    List<PropertiesItemModel>? properties,
    List<PortfolioPropertyModel>? portfolio,
    List<AdsItemModel>? adsItem,
    String? userLocation,
    String? propertiesErrorMsg,
    String? portfolioErrorMsg,
    String? adsErrorMsg,
    RequestStatus? propertiesStatus,
    RequestStatus? portfolioStatus,
    RequestStatus? adsStatus,
  }) {
    return IndividualHomeState(
      properties: properties ?? this.properties,
      portfolio: portfolio ?? this.portfolio,
      userLocation: userLocation ?? this.userLocation,
      adsItem: adsItem ?? this.adsItem,
      propertiesErrorMsg: propertiesErrorMsg ?? this.propertiesErrorMsg,
      portfolioErrorMsg: portfolioErrorMsg ?? this.portfolioErrorMsg,
      adsErrorMsg: adsErrorMsg ?? this.adsErrorMsg,
      propertiesStatus: propertiesStatus ?? this.propertiesStatus,
      portfolioStatus: portfolioStatus ?? this.portfolioStatus,
      adsStatus: adsStatus ?? this.adsStatus,
    );
  }
}
