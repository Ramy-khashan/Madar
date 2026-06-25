import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../controller/notification_bloc.dart';
import '../model/notification_model.dart';

part 'widget/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                status: state.loadingStatus,
                errorMsg: AppStrings.somethingWentWrong,
                onTapRefresh: () =>
                    context.read<NotificationBloc>().add(const NotificationLoad()),
                childIsLoader: true,
                emptyMsg: AppStrings.noNotifications,
                isEmptyList: state.notifications.isEmpty,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8.height),
                  itemCount: state.loadingStatus == RequestStatus.loading
                      ? 10
                      : state.notifications.length,
                  separatorBuilder: (_, __) => Divider(
                    color: AppThemeColors.of(context).borderColor,
                    indent: 16.width,
                    endIndent: 16.width,
                    height: 1,
                  ),
                  itemBuilder: (context, i) {
                    final item = state.loadingStatus == RequestStatus.loading
                        ? null
                        : state.notifications[i];
                    return NotificationItem(
                      item: item,
                      onTap: () {
                        if (item != null && !item.isRead) {
                          context
                              .read<NotificationBloc>()
                              .add(NotificationMarkAsRead(item.id));
                        }
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
 
    );
  }
}