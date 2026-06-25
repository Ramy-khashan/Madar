import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/auction_list_bloc.dart';
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
                status: state.loadStatus,
                errorMsg: state.errorMsg,
                onTapRefresh: () => context.read<AuctionListBloc>().add(
                  const AuctionListLoad(),
                ),
                emptyMsg: AppStrings.noAuctions,
                isEmptyList:
                    state.loadStatus == RequestStatus.success &&
                    state.filteredItems.isEmpty,
                childIsLoader: true,
                child: AuctionListContentWidget(
                  isLoading: state.loadStatus == RequestStatus.loading,
                ),
              ),
            ),
          );
        },
      
    );
  }
}
