part of 'business_properties_bloc.dart';

final class BusinessPropertiesState extends Equatable {
  const BusinessPropertiesState({
    this.currentTab = 0,
    this.requests = const [],
    this.published = const [],
  });

  final int currentTab;
  final List<BusinessPropertyRequestModel> requests;
  final List<BusinessPortfolioPropertyModel> published;

  BusinessPropertiesState copyWith({
    int? currentTab,
    List<BusinessPropertyRequestModel>? requests,
    List<BusinessPortfolioPropertyModel>? published,
  }) {
    return BusinessPropertiesState(
      currentTab: currentTab ?? this.currentTab,
      requests: requests ?? this.requests,
      published: published ?? this.published,
    );
  }

  @override
  List<Object> get props => [currentTab, requests, published];
}

final class BusinessPropertiesInitial extends BusinessPropertiesState {}
