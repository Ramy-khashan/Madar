import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme_colors.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../controller/contract_details_bloc.dart';
import 'widgets/contract_actions_part.dart';
import 'widgets/contract_details_content_widget.dart';

class ContractDetailsScreen extends StatelessWidget {
  const ContractDetailsScreen({super.key, required this.contractId});

  final String contractId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
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
