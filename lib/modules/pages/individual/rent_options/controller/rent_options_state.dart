part of 'rent_options_bloc.dart';

class RentOptionsState extends Equatable {
  const RentOptionsState({
    this.plans = const [],
    this.providers = const [],
    this.selectedPlanId,
    this.selectedProviderId,
    this.propertyTitle = '',
    this.propertyLocation = '',
    this.propertyPrice = 0,
    this.propertyType = '',
    this.getDetailsStatus = RequestStatus.init,
    this.errorMsg = '',
    this.confirmStatus = RequestStatus.init,
    this.requestNumber = '',
  });

  final List<InstallmentPlanModel> plans;
  final List<InstallmentProviderModel> providers;
  final String? selectedPlanId;
  final String? selectedProviderId;
  final String propertyTitle;
  final String propertyLocation;
  final double propertyPrice;
  final String propertyType;
  final RequestStatus getDetailsStatus;
  final String errorMsg;
  final RequestStatus confirmStatus;
  final String requestNumber;

  InstallmentPlanModel? get selectedPlan =>
      selectedPlanId == null
          ? null
          : plans.where((p) => p.id == selectedPlanId).firstOrNull;

  InstallmentProviderModel? get selectedProvider =>
      selectedProviderId == null
          ? null
          : providers.where((p) => p.id == selectedProviderId).firstOrNull;

  @override
  List<Object?> get props => [
        plans, providers, selectedPlanId, selectedProviderId,
        propertyTitle, propertyLocation, propertyPrice, propertyType,
        getDetailsStatus, errorMsg, confirmStatus, requestNumber,
      ];

  RentOptionsState copyWith({
    List<InstallmentPlanModel>? plans,
    List<InstallmentProviderModel>? providers,
    String? selectedPlanId,
    String? selectedProviderId,
    String? propertyTitle,
    String? propertyLocation,
    double? propertyPrice,
    String? propertyType,
    RequestStatus? getDetailsStatus,
    String? errorMsg,
    RequestStatus? confirmStatus,
    String? requestNumber,
  }) {
    return RentOptionsState(
      plans: plans ?? this.plans,
      providers: providers ?? this.providers,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      selectedProviderId: selectedProviderId ?? this.selectedProviderId,
      propertyTitle: propertyTitle ?? this.propertyTitle,
      propertyLocation: propertyLocation ?? this.propertyLocation,
      propertyPrice: propertyPrice ?? this.propertyPrice,
      propertyType: propertyType ?? this.propertyType,
      getDetailsStatus: getDetailsStatus ?? this.getDetailsStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      confirmStatus: confirmStatus ?? this.confirmStatus,
      requestNumber: requestNumber ?? this.requestNumber,
    );
  }
}
