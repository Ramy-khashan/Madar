import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/components/pagination.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/time_ago.dart';
import '../controller/notification_bloc.dart';
import '../model/notification_model.dart';
import 'widget/notification_loading_item.dart';

part 'widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: AppStrings.notifications),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return Container(
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
                pageSize: NotificationBloc.get(context).pageSize,
                items: state.notifications,
                itemBuilder: (context, index) {
                  final item = state.notifications[index];
                  return NotificationItem(item: item, onTap: () {});
                },
                requestStatus: state.notificationStatus,
                hasReachedMax: state.notifications.length >= state.totalCount,
                onLoadMore: (page) => context.read<NotificationBloc>().add(
                  NotificationLoad(page: page, isLoadMore: true),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
