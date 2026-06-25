part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const [],
    this.loadingStatus = RequestStatus.init,
  });

  final List<NotificationModel> notifications;
  final RequestStatus loadingStatus;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    RequestStatus? loadingStatus,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }

  @override
  List<Object> get props => [notifications, loadingStatus];
}
