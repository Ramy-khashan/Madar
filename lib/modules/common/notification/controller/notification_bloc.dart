import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/connection/concept/end_points.dart';
import '../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/functions/print_state.dart';
import '../../../../core/utils/functions/service_locator.dart';
import '../model/notification_model.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<NotificationLoad>(_onLoad);
    on<NotificationMarkAsRead>(_onMarkAsRead);
  }

  static NotificationBloc get(BuildContext context) =>
      BlocProvider.of<NotificationBloc>(context);
  int pageSize = 20;
  Future<void> _onLoad(
    NotificationLoad event,
    Emitter<NotificationState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          notificationStatus: RequestStatus.loading,
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
            successResponse.response['notifications'],
          )) {
            items.add(NotificationModel.fromJson(item));
          }

          emit(
            state.copyWith(
              notificationStatus: RequestStatus.success,
              notifications: items,
              totalCount: successResponse.response['total'],
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
    // final updated = state.notifications.map((n) {
    //   return n.id == event.id ? n.copyWith(isRead: true) : n;
    // }).toList();
    // emit(state.copyWith(notifications: updated));
  }
}
