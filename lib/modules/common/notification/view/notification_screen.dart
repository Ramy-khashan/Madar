import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/guest_locked_view.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/components/pagination.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/common_fun.dart';
import '../../../../core/utils/functions/guest_mode.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../../../../core/utils/functions/time_ago.dart';
import '../controller/notification_bloc.dart';
import '../model/notification_model.dart';
import 'widget/notification_loading_item.dart';

part 'widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  void _onNotificationTap(BuildContext context, NotificationModel item) {
    final id = item.id;
    if (id != null && id.isNotEmpty && item.isRead != true) {
      context.read<NotificationBloc>().add(NotificationMarkAsRead(id));
    }

    final contractId = item.contractId;
    if (contractId != null && contractId.isNotEmpty) {
      RouterHandler.navigate(
        context,
        AppRouterKeys.contractDetails,
        extra: contractId,
      );
      return;
    }

    final propertyId = item.propertyId;
    if (propertyId != null && propertyId.isNotEmpty) {
      RouterHandler.navigate(
        context,
        AppRouterKeys.propertyDetails,
        extra: propertyId,
      );
      return;
    }

    if (item.isAuctionType || (item.bidId ?? '').isNotEmpty) {
      AppToast(AppStrings.comingSoon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listenWhen: (previous, current) =>
          previous.markAllStatus != current.markAllStatus,
      listener: (context, state) {
        if (state.markAllStatus == RequestStatus.failed &&
            state.errorMsg.isNotEmpty) {
          AppToast(state.errorMsg);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppAppbar(
            title: AppStrings.notifications,
            actions: [
              if (!GuestMode.isGuest && state.unreadCount > 0)
                TextButton(
                  onPressed: state.markAllStatus == RequestStatus.loading
                      ? null
                      : () => context.read<NotificationBloc>().add(
                          const NotificationMarkAllAsRead(),
                        ),
                  child: Text(AppStrings.markAllAsRead),
                ),
            ],
          ),
          body: GuestMode.isGuest
              ? const GuestLockedView()
              : Container(
            decoration: BoxDecoration(
              color: AppThemeColors.of(context).backgroundPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: LoadingProcess(
              status: state.isLoadMore
                  ? RequestStatus.success
                  : state.notificationStatus,
              errorMsg: AppStrings.somethingWentWrong,
              onTapRefresh: () => context.read<NotificationBloc>().add(
                const NotificationLoad(),
              ),
              emptyMsg: AppStrings.noNotifications,
              isEmptyList: state.notifications.isEmpty,
              loader: const NotificationLoadingItem(),
              child: PaginationView(
                isListView: context.isMobilePortrait,
                pageSize: NotificationBloc.get(context).pageSize,
                items: state.notifications,
                itemBuilder: (context, index) {
                  final item = state.notifications[index];
                  return NotificationItem(
                    item: item,
                    onTap: () => _onNotificationTap(context, item),
                  );
                },
                requestStatus: state.notificationStatus,
                hasReachedMax: state.notifications.length >= state.totalCount,
                onLoadMore: (page) => context.read<NotificationBloc>().add(
                  NotificationLoad(page: page, isLoadMore: true),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
