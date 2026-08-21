part of 'business_properties_bloc.dart';

final class BusinessPropertiesState extends Equatable {
  const BusinessPropertiesState({
    this.currentTab = 0,
    this.requests = const [],
    this.published = const [],
    this.requestsStatus = RequestStatus.init,
    this.publishedStatus = RequestStatus.init,
    this.actionStatus = RequestStatus.init,
    this.actionRequestId,
    this.requestsErrorMessage = '',
    this.publishedErrorMessage = '',
    this.actionMessage = '',
  });

  final int currentTab;
  final List<BusinessPropertyRequestModel> requests;
  final List<BusinessRequestPublishedPropertyModel> published;
  final RequestStatus requestsStatus;
  final RequestStatus publishedStatus;
  final RequestStatus actionStatus;
  final String? actionRequestId;
  final String requestsErrorMessage;
  final String publishedErrorMessage;
  final String actionMessage;

  BusinessPropertiesState copyWith({
    int? currentTab,
    List<BusinessPropertyRequestModel>? requests,
    List<BusinessRequestPublishedPropertyModel>? published,
    RequestStatus? requestsStatus,
    RequestStatus? publishedStatus,
    RequestStatus? actionStatus,
    String? actionRequestId,
    bool clearActionRequestId = false,
    String? requestsErrorMessage,
    String? publishedErrorMessage,
    String? actionMessage,
  }) {
    return BusinessPropertiesState(
      currentTab: currentTab ?? this.currentTab,
      requests: requests ?? this.requests,
      published: published ?? this.published,
      requestsStatus: requestsStatus ?? this.requestsStatus,
      publishedStatus: publishedStatus ?? this.publishedStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      actionRequestId: clearActionRequestId
          ? null
          : actionRequestId ?? this.actionRequestId,
      requestsErrorMessage: requestsErrorMessage ?? this.requestsErrorMessage,
      publishedErrorMessage:
          publishedErrorMessage ?? this.publishedErrorMessage,
      actionMessage: actionMessage ?? this.actionMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentTab,
    requests,
    published,
    requestsStatus,
    publishedStatus,
    actionStatus,
    actionRequestId,
    requestsErrorMessage,
    publishedErrorMessage,
    actionMessage,
  ];
}
