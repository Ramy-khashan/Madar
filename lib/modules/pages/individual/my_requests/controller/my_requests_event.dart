part of 'my_requests_bloc.dart';

abstract class MyRequestsEvent extends Equatable {
  const MyRequestsEvent();

  @override
  List<Object?> get props => [];
}

class MyRequestsLoad extends MyRequestsEvent {
  const MyRequestsLoad();
}

class MyRequestDetailsLoad extends MyRequestsEvent {
  const MyRequestDetailsLoad(this.requestId);

  final String requestId;

  @override
  List<Object?> get props => [requestId];
}

class MyRequestDelete extends MyRequestsEvent {
  const MyRequestDelete(this.requestId);

  final String requestId;

  @override
  List<Object?> get props => [requestId];
}

class MyRequestUpdateStatus extends MyRequestsEvent {
  const MyRequestUpdateStatus({
    required this.requestId,
    required this.status,
  });

  final String requestId;
  final String status;

  @override
  List<Object?> get props => [requestId, status];
}
