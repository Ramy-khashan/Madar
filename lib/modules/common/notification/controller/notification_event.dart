part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

final class NotificationLoad extends NotificationEvent {
  const NotificationLoad();
}

final class NotificationMarkAsRead extends NotificationEvent {
  const NotificationMarkAsRead(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
