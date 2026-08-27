part of 'my_requests_bloc.dart';

class MyRequestsState extends Equatable {
  const MyRequestsState({
    this.requests = const [],
    this.details,
    this.requestId = '',
    this.listStatus = RequestStatus.init,
    this.detailsStatus = RequestStatus.init,
    this.actionStatus = RequestStatus.init,
    this.actionRequestId = '',
    this.actionMessage = '',
    this.errorMsg = '',
  });

  final List<MyPropertyRequestModel> requests;
  final MyPropertyRequestModel? details;
  final String requestId;
  final RequestStatus listStatus;
  final RequestStatus detailsStatus;
  final RequestStatus actionStatus;
  final String actionRequestId;
  final String actionMessage;
  final String errorMsg;

  @override
  List<Object?> get props => [
    requests,
    details,
    requestId,
    listStatus,
    detailsStatus,
    actionStatus,
    actionRequestId,
    actionMessage,
    errorMsg,
  ];

  MyRequestsState copyWith({
    List<MyPropertyRequestModel>? requests,
    MyPropertyRequestModel? details,
    bool clearDetails = false,
    String? requestId,
    RequestStatus? listStatus,
    RequestStatus? detailsStatus,
    RequestStatus? actionStatus,
    String? actionRequestId,
    String? actionMessage,
    String? errorMsg,
  }) {
    return MyRequestsState(
      requests: requests ?? this.requests,
      details: clearDetails ? null : (details ?? this.details),
      requestId: requestId ?? this.requestId,
      listStatus: listStatus ?? this.listStatus,
      detailsStatus: detailsStatus ?? this.detailsStatus,
      actionStatus: actionStatus ?? this.actionStatus,
      actionRequestId: actionRequestId ?? this.actionRequestId,
      actionMessage: actionMessage ?? this.actionMessage,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
