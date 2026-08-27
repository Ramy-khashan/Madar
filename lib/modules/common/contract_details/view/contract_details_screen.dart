import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/common_fun.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/contract_details_bloc.dart';
import 'widgets/contract_actions_part.dart';
import 'widgets/contract_details_content_widget.dart';

class ContractDetailsScreen extends StatelessWidget {
  const ContractDetailsScreen({super.key, required this.contractId});

  final String contractId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContractDetailsBloc, ContractDetailsState>(
      listenWhen: (prev, curr) => prev.actionStatus != curr.actionStatus,
      listener: (context, state) {
        if (state.actionStatus == RequestStatus.failed &&
            state.actionMessage.isNotEmpty) {
          AppToast(state.actionMessage, isError: true);
        } else if (state.actionStatus == RequestStatus.success &&
            state.actionMessage.isNotEmpty) {
          AppToast(state.actionMessage);
          if (state.shouldPop) {
            RouterHandler.pop(context, true);
          } else {
            context.read<ContractDetailsBloc>().add(
              ContractDetailsLoad(contractId),
            );
          }
        }
      },
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.contractDetailsTitle),
          body: SafeArea(
            child: LoadingProcess(
              status: state.loadStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () => context.read<ContractDetailsBloc>().add(
                ContractDetailsLoad(contractId),
              ),
              emptyMsg: AppStrings.noContracts,
              isEmptyList:
                  state.loadStatus == RequestStatus.success &&
                  state.contract == null,
              childIsLoader: true,
              child: ContractDetailsContentWidget(contract: state.contract),
            ),
          ),
          bottomNavigationBar: const ContractActionsPart(),
        );
      },
    );
  }
}
