part of 'property_insurance_bloc.dart';

class PropertyInsuranceState extends Equatable {
  final int selectedTab; // 0 = requests, 1 = info
  final List<InsuranceRequestModel> requests;
  final List<InsuranceOfferModel> offers;
  final List<CoverageRiskModel> coverageRisks;

  const PropertyInsuranceState({
    this.selectedTab = 0,
    this.requests = const [],
    this.offers = const [],
    this.coverageRisks = const [],
  });

  PropertyInsuranceState copyWith({
    int? selectedTab,
    List<InsuranceRequestModel>? requests,
    List<InsuranceOfferModel>? offers,
    List<CoverageRiskModel>? coverageRisks,
  }) =>
      PropertyInsuranceState(
        selectedTab: selectedTab ?? this.selectedTab,
        requests: requests ?? this.requests,
        offers: offers ?? this.offers,
        coverageRisks: coverageRisks ?? this.coverageRisks,
      );

  @override
  List<Object> get props => [selectedTab, requests, offers, coverageRisks];
}
