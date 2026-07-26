import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../controller/auction_list_bloc.dart';
import 'widgets/auction_card_widget.dart';
import 'widgets/auction_list_content_widget.dart';

class AuctionListScreen extends StatelessWidget {
  const AuctionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionListBloc, AuctionListState>(
      builder: (context, state) {
        final colors = AppThemeColors.of(context);
        return Scaffold(
          backgroundColor: colors.backgroundPrimary,
          appBar: AppAppbar(title: AppStrings.auctionListTitle),
          body: SafeArea(
            child: LoadingProcess(
              status: state.isLoadMore
                  ? RequestStatus.success
                  : state.loadStatus,
              errorMsg: state.errorMsg,
              onTapRefresh: () =>
                  context.read<AuctionListBloc>().add(const AuctionListLoad()),
              emptyMsg: AppStrings.noAuctions,
              isEmptyList:
                  state.loadStatus == RequestStatus.success &&
                  state.allItems.isEmpty,
              loader: GridView.builder(
                padding: EdgeInsets.only(
                  left: 12.width,
                  right: 12.width,
                  bottom: 40.height,
                  top: 8.height,
                ),
                itemCount: 12,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 1,
                    mobileLandscape: 2,
                    tabletPortrait: 2,
                    tabletLandscape: 3,
                  ).toInt(),
                  mainAxisExtent: ResponsiveUtils.types(
                    context,
                    mobilePortrait: 480.height,
                    mobileLandscape: 580.height,
                    tabletPortrait: 580.height,
                    tabletLandscape: 500.height,
                  ),
                  crossAxisSpacing: 12.width,
                  mainAxisSpacing: 12.height,
                ),
                itemBuilder: (_, i) => const AuctionCardWidget(item: null),
              ),
              child: AuctionListContentWidget(
                isLoading:
                    state.loadStatus == RequestStatus.loading &&
                    !state.isLoadMore,
              ),
            ),
          ),
        );
      },
    );
  }
}
