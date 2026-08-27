import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/guest_mode.dart';
import '../../../../core/utils/functions/print_state.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../model/notification_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<NotificationLoad>(_onLoad);
    on<NotificationMarkAsRead>(_onMarkAsRead);
    on<NotificationMarkAllAsRead>(_onMarkAllAsRead);
  }

  static NotificationBloc get(BuildContext context) =>
      BlocProvider.of<NotificationBloc>(context);
  int pageSize = 20;

  Future<void> _onLoad(
    NotificationLoad event,
    Emitter<NotificationState> emit,
  ) async {
    if (GuestMode.isGuest) {
      emit(
        state.copyWith(
          notificationStatus: RequestStatus.success,
          isLoadMore: false,
        ),
      );
      return;
    }
    try {
      emit(
        state.copyWith(
          notificationStatus: event.isLoadMore
              ? state.notificationStatus
              : RequestStatus.loading,
          isLoadMore: event.isLoadMore,
        ),
      );
      final response = await sl.get<ApiConsumer>().get(
        EndPoints.notifications,
        queryParameters: {'page': event.page, 'limit': pageSize},
      );
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              notificationStatus: RequestStatus.failed,
              errorMsg: failedResponse,
              isLoadMore: false,
            ),
          );
        },
        (successResponse) async {
          final List<NotificationModel> items = [];
          for (var item in List.from(
            successResponse.response['notifications'] ?? const [],
          )) {
            items.add(
              NotificationModel.fromJson(Map<String, dynamic>.from(item)),
            );
          }

          emit(
            state.copyWith(
              notificationStatus: RequestStatus.success,
              notifications: event.isLoadMore
                  ? [...state.notifications, ...items]
                  : items,
              totalCount: (successResponse.response['total'] as num?)?.toInt() ??
                  items.length,
              unreadCount:
                  (successResponse.response['unreadCount'] as num?)?.toInt() ??
                  0,
              isLoadMore: false,
            ),
          );
        },
      );
    } catch (e) {
      printState(e.toString());

      emit(
        state.copyWith(
          notificationStatus: RequestStatus.failed,
          errorMsg: e.toString(),
          isLoadMore: false,
        ),
      );
    }
  }

  Future<void> _onMarkAsRead(
    NotificationMarkAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    if (event.id.isEmpty) return;
    final current = state.notifications.cast<NotificationModel?>().firstWhere(
      (n) => n?.id == event.id,
      orElse: () => null,
    );
    if (current == null || current.isRead == true) return;

    emit(
      state.copyWith(
        notifications: state.notifications
            .map((n) => n.id == event.id ? n.copyWith(isRead: true) : n)
            .toList(),
        unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
      ),
    );

    try {
      final response = await sl.get<ApiConsumer>().patch(
        EndPoints.notificationRead(event.id),
      );
      response.fold(
        (failedResponse) {
          printState('mark as read failed: $failedResponse');
        },
        (successResponse) {
          printState('PATCH /notifications/${event.id}/read: ${successResponse.response}');
        },
      );
    } catch (e) {
      printState(e.toString());
    }
  }

  Future<void> _onMarkAllAsRead(
    NotificationMarkAllAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    if (state.unreadCount <= 0) return;
    emit(state.copyWith(markAllStatus: RequestStatus.loading));
    try {
      final response = await sl.get<ApiConsumer>().patch(
        EndPoints.notificationsReadAll,
      );
      await response.fold(
        (failedResponse) async {
          emit(
            state.copyWith(
              markAllStatus: RequestStatus.failed,
              errorMsg: failedResponse,
            ),
          );
        },
        (successResponse) async {
          printState('PATCH /notifications/read: ${successResponse.response}');
          emit(
            state.copyWith(
              markAllStatus: RequestStatus.success,
              unreadCount: 0,
              notifications: state.notifications
                  .map((n) => n.copyWith(isRead: true))
                  .toList(),
            ),
          );
        },
      );
    } catch (e) {
      printState(e.toString());
      emit(
        state.copyWith(
          markAllStatus: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }
}
