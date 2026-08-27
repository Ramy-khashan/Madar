part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.notifications = const [],
    this.notificationStatus = RequestStatus.init,
    this.errorMsg = '',
    this.isLoadMore = false,
    this.totalCount = 0,
    this.unreadCount = 0,
    this.markAllStatus = RequestStatus.init,
  });

  final List<NotificationModel> notifications;
  final RequestStatus notificationStatus;
  final String errorMsg;
  final bool isLoadMore;
  final int totalCount;
  final int unreadCount;
  final RequestStatus markAllStatus;

  NotificationState copyWith({
    List<NotificationModel>? notifications,
    RequestStatus? notificationStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
    int? unreadCount,
    RequestStatus? markAllStatus,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      errorMsg: errorMsg ?? this.errorMsg,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      totalCount: totalCount ?? this.totalCount,
      unreadCount: unreadCount ?? this.unreadCount,
      markAllStatus: markAllStatus ?? this.markAllStatus,
    );
  }

  @override
  List<Object> get props => [
    notifications,
    notificationStatus,
    errorMsg,
    isLoadMore,
    totalCount,
    unreadCount,
    markAllStatus,
  ];
}
