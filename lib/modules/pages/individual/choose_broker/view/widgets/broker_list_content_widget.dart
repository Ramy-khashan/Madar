import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/loading_process.dart';
import '../../../../../../core/components/pagination.dart';
import '../../../../../../core/components/search_item.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/choose_broker_bloc.dart';
import 'broker_card_widget.dart';

class BrokerListContentWidget extends StatelessWidget {
  const BrokerListContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return BlocBuilder<ChooseBrokerBloc, ChooseBrokerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: context.responsiveHorizontalPadding,
                right: context.responsiveHorizontalPadding,
                top: 10.height,
              ),
              child: Text(
                AppStrings.brokerWillManage,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(13),
                  fontFamily: AppConstant.appHeaderFont,
                  color: colors.textSecondary,
                ),
              ),
            ),
            const SearchItem(),
            Expanded(
              child: LoadingProcess(
                status: state.isLoadMore
                    ? RequestStatus.success
                    : state.loadStatus,
                errorMsg: AppStrings.somethingWentWrong,
                onTapRefresh: () => context.read<ChooseBrokerBloc>().add(
                  const ChooseBrokerLoad(),
                ),
                emptyMsg: AppStrings.chooseBrokerTitle,
                isEmptyList: state.brokers.isEmpty,
                child: PaginationView(
                  pageSize: ChooseBrokerBloc.get(context).pageSize,
                  items: state.filteredBrokers,
                  mainAxisExtent: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 305.height,
                    mobileLandscape: 335.height,
                    tabletPortrait: 225.height,
                    tabletLandscape: 355.height,
                  ),
                  countItemInRow: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 1,
                    mobileLandscape: 2,
                    tabletPortrait: 2,
                    tabletLandscape: 3,
                  ).toInt(),
                  requestStatus: state.loadStatus,
                  hasReachedMax: state.brokers.length >= state.totalCount,
                  onLoadMore: (page) =>
                      ChooseBrokerBloc.get(context).add(
                        ChooseBrokerLoad(page: page, isLoadMore: true),
                      ),
                  itemBuilder: (_, i) =>
                      BrokerCardWidget(broker: state.filteredBrokers[i]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
