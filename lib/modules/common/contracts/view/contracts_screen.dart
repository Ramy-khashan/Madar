import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/components/guest_locked_view.dart';
import '../../../../core/components/loading_process.dart';
import '../../../../core/components/pagination.dart';
import '../../../../core/utils/constants/app_enums.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../../../core/utils/functions/guest_mode.dart';
import '../../../../core/utils/functions/responsive.dart';
import '../../../../core/utils/functions/router_handler.dart';
import '../controller/contracts_bloc.dart';
import 'widgets/contract_card_widget.dart';
import 'widgets/contracts_filter_tabs_widget.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(isWithBack: false, title: AppStrings.contracts),
      body: GuestMode.isGuest
          ? const GuestLockedView()
          : SafeArea(
        child: BlocBuilder<ContractsBloc, ContractsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContractsFilterTabsWidget(
                  selectedFilter: state.selectedFilter,
                  totalCount: state.totalCount,
                  counts: state.counts,
                  onFilterChanged: (filter) => ContractsBloc.get(
                    context,
                  ).add(ContractsFilterChanged(filter)),
                ),
                Expanded(
                  child: LoadingProcess(
                    status: state.isLoadMore
                        ? RequestStatus.success
                        : state.contractsStatus,
                    errorMsg: AppStrings.somethingWentWrong,
                    onTapRefresh: () => context.read<ContractsBloc>().add(
                      const ContractsLoad(),
                    ),
                    loader: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveUtils.types(
                          context,
                          mobilePortrait: 1,
                          mobileLandscape: 2,
                          tabletPortrait: 2,
                          tabletLandscape: 3,
                        ).toInt(),
                        mainAxisSpacing: 12.height,
                        crossAxisSpacing: 12.width,
                        mainAxisExtent: ResponsiveUtils.types(
                          context,
                          mobilePortrait: 120.height,
                          mobileLandscape: 125.height,
                          tabletPortrait: 85.height,
                          tabletLandscape: 120.height,
                        ),
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) =>
                          const ContractCardWidget(
                            contract: null,
                            onTap: null,
                          ),
                    ),
                    emptyMsg: AppStrings.noContracts,
                    isEmptyList: state.contracts.isEmpty,
                    child: PaginationView(
                      key: ValueKey(state.selectedFilter),
                      pageSize: ContractsBloc.get(context).pageSize,
                      items: state.contracts,
                      mainAxisExtent: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 120.height,
                        mobileLandscape: 125.height,
                        tabletPortrait: 85.height,
                        tabletLandscape: 120.height,
                      ),
                      countItemInRow: ResponsiveUtils.types(
                        context,
                        mobilePortrait: 1,
                        mobileLandscape: 2,
                        tabletPortrait: 2,
                        tabletLandscape: 3,
                      ).toInt(),
                      requestStatus: state.contractsStatus,
                      hasReachedMax: !state.hasNext &&
                          state.contracts.length >= state.totalCount,
                      onLoadMore: (page) => context.read<ContractsBloc>().add(
                        ContractsLoad(page: page, isLoadMore: true),
                      ),
                      itemBuilder: (context, index) => ContractCardWidget(
                        contract: state.contracts[index],
                        onTap: () => RouterHandler.navigate(
                          context,
                          AppRouterKeys.contractDetails,
                          extra: state.contracts[index].id,
                        ).then((_) {
                          if (!context.mounted) return;
                          context.read<ContractsBloc>().add(
                            const ContractsLoad(),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
