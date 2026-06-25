part of 'rate_property_bloc.dart';

class RatePropertyState extends Equatable {
  const RatePropertyState({
    this.currentTab = 0,
    this.loadStatus = RequestStatus.init,
    this.requests = const [],
    this.errorMsg = '',
  });

  final int currentTab;
  final RequestStatus loadStatus;
  final List<RatePropertyRequestModel> requests;
  final String errorMsg;

  @override
  List<Object?> get props => [currentTab, loadStatus, requests, errorMsg];

  RatePropertyState copyWith({
    int? currentTab,
    RequestStatus? loadStatus,
    List<RatePropertyRequestModel>? requests,
    String? errorMsg,
  }) {
    return RatePropertyState(
      currentTab: currentTab ?? this.currentTab,
      loadStatus: loadStatus ?? this.loadStatus,
      requests: requests ?? this.requests,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
