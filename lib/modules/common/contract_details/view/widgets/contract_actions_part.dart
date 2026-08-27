import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/app_button.dart';
import '../../../../../core/components/responsive_row_column.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_constant.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/constants/storage_keys.dart';
import '../../../../../core/utils/functions/preference_utils.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/router_handler.dart';
import '../../controller/contract_details_bloc.dart';
import 'approve_contract_dialog.dart';

class ContractActionsPart extends StatelessWidget {
  const ContractActionsPart({super.key});

  bool get _isBroker =>
      PreferenceUtils().getString(StorageKeys.accountType) ==
      AppConstant.business;

  bool get _isIndividual =>
      PreferenceUtils().getString(StorageKeys.accountType) ==
      AppConstant.individual;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
      builder: (context, state) {
        final contract = state.contract;
        if (contract == null) return const SizedBox.shrink();
        final loading = state.actionStatus == RequestStatus.loading;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.width),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isIndividual)
                  AppButton(
                    width: 560.width,
                    onTap: () {},
                    text: AppStrings.downloadPdf,
                  ),
                if (_isBroker && contract.isPending)
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          childText: AppStrings.businessPropertiesReject,
                          childIcon: Icons.close,
                          colorBG: AppColors.errorColor.shade100,
                          textColor: AppColors.errorColor,
                          borderColor: AppColors.errorColor,
                          isLoading: loading,
                          onTap: () => _reject(context),
                        ),
                      ),
                      SizedBox(width: 12.width),
                      Expanded(
                        child: AppButton(
                          childText: AppStrings.businessPropertiesAccept,
                          childIcon: Icons.check,
                          colorBG: AppColors.successColor,
                          isLoading: loading,
                          onTap: () => _approve(context, state),
                        ),
                      ),
                    ],
                  ),
                if (_isBroker && contract.isActive)
                  ResponsiveRowColumn(
                    isTablet: context.isTablet,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: context.isTablet ? 1 : 0,
                        child: AppButton(
                          width: 560.width,
                          isLoading: loading,
                          onTap: () => context.read<ContractDetailsBloc>().add(
                            const ContractDetailsRenew(),
                          ),
                          text: AppStrings.renewalContract,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _reject(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.businessPropertiesReject),
        content: Text(AppStrings.contractRejectConfirmation),
        actions: [
          TextButton(
            onPressed: () =>RouterHandler.pop(context,[false]),
            child: Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => RouterHandler.pop(context,[true]),
            child: Text(AppStrings.confirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    context.read<ContractDetailsBloc>().add(const ContractDetailsReject());
  }

  Future<void> _approve(
    BuildContext context,
    ContractDetailsState state,
  ) async {
    final result = await showDialog<ApproveContractResult>(
      context: context,
      builder: (_) => ApproveContractDialog(
        initialPrice: state.contract?.totalContractValue,
        showDuration: state.contract?.isRent == true,
      ),
    );
    if (result == null || !context.mounted) return;
    context.read<ContractDetailsBloc>().add(
      ContractDetailsApprove(
        durationInYears: result.durationInYears,
        finalPrice: result.finalPrice,
      ),
    );
  }
}
