part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const [],
    this.notificationStatus = RequestStatus.init,
    this.errorMsg = '',
    this.isLoadMore = false,
    this.totalCount = 0,
  });

  final List<NotificationModel> notifications;
  final RequestStatus notificationStatus;
  final String errorMsg;
  final bool isLoadMore;
  final int totalCount;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    RequestStatus? notificationStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
    );
  }

  @override
  List<Object> get props => [
    notifications,
    notificationStatus,
    errorMsg,
    isLoadMore,
    totalCount,
  ];
}
