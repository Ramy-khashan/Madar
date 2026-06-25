 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/app_enums.dart';
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

  static const List<NotificationModel> _mockNotifications = [
    NotificationModel(
      id: '1',
      title: 'رسالة جديدة',
      body: 'لديك رسالة جديدة من مكتب الرياض العقاري',
      time: 'منذ دقيقتين',
      type: NotificationType.message,
      isRead: false,
    ),
    NotificationModel(
      id: '2',
      title: 'عقار جديد',
      body: 'تم إضافة عقار جديد يطابق معايير بحثك في حي النرجس',
      time: 'منذ ساعة',
      type: NotificationType.property,
      isRead: false,
    ),
    NotificationModel(
      id: '3',
      title: 'تحديث النظام',
      body: 'تم تحديث شروط الاستخدام، يرجى مراجعتها',
      time: 'أمس',
      type: NotificationType.system,
      isRead: true,
    ),
    NotificationModel(
      id: '4',
      title: 'رسالة جديدة',
      body: 'شركة الأندلس العقارية: سنتواصل معك قريباً بخصوص الطلب',
      time: 'الاثنين',
      type: NotificationType.message,
      isRead: true,
    ),
    NotificationModel(
      id: '5',
      title: 'عقار مميز',
      body: 'عقار جديد في المنطقة المفضلة لديك بسعر مناسب',
      time: 'الأحد',
      type: NotificationType.property,
      isRead: true,
    ),
  ];

  Future<void> _onLoad(
    NotificationLoad event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: RequestStatus.loading));
    emit(state.copyWith(
      notifications: _mockNotifications,
      loadingStatus: RequestStatus.success,
    ));
  }

  Future<void> _onMarkAsRead(
    NotificationMarkAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final updated = state.notifications.map((n) {
      return n.id == event.id ? n.copyWith(isRead: true) : n;
    }).toList();
    emit(state.copyWith(notifications: updated));
  }
}
