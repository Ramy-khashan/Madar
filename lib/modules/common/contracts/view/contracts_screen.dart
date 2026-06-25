import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/router/app_router_keys.dart';
import '../../../../core/components/app_appbar.dart';
import '../../../../core/utils/constants/app_strings.dart';
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
      body: SafeArea(
        child: BlocBuilder<ContractsBloc, ContractsState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContractsFilterTabsWidget(
                  selectedFilter: state.selectedFilter,
                  counts: {
                    'all': state.countFor(
                      'all',
                    ),
                    'active': state.countFor(
                      'active',
                    ),
                    'completed': state.countFor(
                      'completed',
                    ),
                  },
                  onFilterChanged: (filter) => ContractsBloc.get(
                    context,
                  ).add(ContractsFilterChanged(filter)),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: GridView.builder(
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
                      key: ValueKey(state.selectedFilter),
                      padding: EdgeInsets.only(
                        top: 4.height,
                        bottom: 24.height,
                        left: 16.width,
                        right: 16.width,
                      ),
                      itemCount: state.filtered.length,
                      itemBuilder: (context, index) => ContractCardWidget(
                        contract: state.filtered[index],
                        onTap: () => RouterHandler.navigate(
                          context,
                          AppRouterKeys.contractDetails,
                          extra: state.filtered[index].id,
                        ),
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
