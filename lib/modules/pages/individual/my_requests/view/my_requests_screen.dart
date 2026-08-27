import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/guest_locked_view.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/guest_mode.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/my_requests_bloc.dart';
import 'widgets/my_request_card_widget.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyRequestsBloc, MyRequestsState>(
      listenWhen: (prev, curr) => prev.actionStatus != curr.actionStatus,
      listener: (context, state) {
        if (state.actionStatus == RequestStatus.failed &&
            state.actionMessage.isNotEmpty) {
          AppToast(state.actionMessage, isError: true);
        } else if (state.actionStatus == RequestStatus.success &&
            state.actionMessage.isNotEmpty) {
          AppToast(state.actionMessage);
        }
      },
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.myRequestsTitle),
          body: GuestMode.isGuest
              ? const GuestLockedView()
              : SafeArea(
            child: LoadingProcess(
              status: state.listStatus,
              errorMsg: state.errorMsg,
              emptyMsg: AppStrings.myRequestsEmpty,
              isEmptyList: state.requests.isEmpty,
              childIsLoader: true,
              onTapRefresh: () =>
                  context.read<MyRequestsBloc>().add(const MyRequestsLoad()),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveHorizontalPadding,
                  vertical: 16.height,
                ),
                itemCount: state.listStatus == RequestStatus.loading
                    ? 4
                    : state.requests.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.height),
                itemBuilder: (context, index) {
                  if (state.listStatus == RequestStatus.loading) {
                    return const MyRequestCardWidget();
                  }
                  final item = state.requests[index];
                  return MyRequestCardWidget(
                    item: item,
                    isActionLoading:
                        state.actionStatus == RequestStatus.loading &&
                        state.actionRequestId == item.id,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}