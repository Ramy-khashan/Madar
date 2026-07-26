import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/components/loading_process.dart';
import '../../../../../../core/components/pagination.dart';
import '../../../../../../core/components/search_item.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/auction_list_bloc.dart';
import 'auction_card_widget.dart';

class AuctionListContentWidget extends StatelessWidget {
  const AuctionListContentWidget({super.key, required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionListBloc, AuctionListState>(
      builder: (context, state) {
        return Column(
          children: [
            const SearchItem(),
            Expanded(
              child: LoadingProcess(
                status: state.isLoadMore
                    ? RequestStatus.success
                    : state.loadStatus,
                errorMsg: state.errorMsg,
                onTapRefresh: () => context.read<AuctionListBloc>().add(
                  const AuctionListLoad(),
                ),
                emptyMsg: AppStrings.noAuctions,
                isEmptyList:
                    state.loadStatus == RequestStatus.success &&
                    state.allItems.isEmpty,
                childIsLoader: true,
                child: PaginationView(
                  pageSize: AuctionListBloc.get(context).pageSize,
                  items: state.allItems,
                  mainAxisExtent: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 480.height,
                    mobileLandscape: 580.height,
                    tabletPortrait: 580.height,
                    tabletLandscape: 500.height,
                  ),
                  countItemInRow: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 1,
                    mobileLandscape: 2,
                    tabletPortrait: 2,
                    tabletLandscape: 3,
                  ).toInt(),
                  requestStatus: state.loadStatus,
                  hasReachedMax: state.allItems.length >= state.totalCount,
                  onLoadMore: (page) => AuctionListBloc.get(
                    context,
                  ).add(AuctionListLoad(page: page, isLoadMore: true)),
                  itemBuilder: (_, i) => AuctionCardWidget(
                    item: isLoading ? null : state.allItems[i],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
