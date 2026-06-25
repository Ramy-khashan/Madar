part of 'rent_installment_bloc.dart';

class RentInstallmentState extends Equatable {
  final int selectedTab; // 0 = requests, 1 = info
  final List<RentInstallmentRequestModel> requests;
  final List<InstallmentProviderInfoModel> providers;

  const RentInstallmentState({
    this.selectedTab = 0,
    this.requests = const [],
    this.providers = const [],
  });

  RentInstallmentState copyWith({
    int? selectedTab,
    List<RentInstallmentRequestModel>? requests,
    List<InstallmentProviderInfoModel>? providers,
  }) =>
      RentInstallmentState(
        selectedTab: selectedTab ?? this.selectedTab,
        requests: requests ?? this.requests,
        providers: providers ?? this.providers,
      );

  @override
  List<Object> get props => [selectedTab, requests, providers];
}
