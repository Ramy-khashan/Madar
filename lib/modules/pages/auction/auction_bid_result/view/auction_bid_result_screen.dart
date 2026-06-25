import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/loading_process.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/auction_bid_result_bloc.dart';
import 'widgets/auction_bid_result_content_widget.dart';

class AuctionBidResultScreen extends StatelessWidget {
  const AuctionBidResultScreen({super.key, this.auctionId = '1'});
  final String auctionId;

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<AuctionBidResultBloc, AuctionBidResultState>(
        builder: (context, state) {
          final colors = AppThemeColors.of(context);
          return Scaffold(
            backgroundColor: colors.backgroundPrimary,
            appBar: AppAppbar(title: AppStrings.bidResultTitle),
            body: SafeArea(
              child: LoadingProcess(
                status: state.loadStatus,
                errorMsg: state.errorMsg,
                onTapRefresh: () => context
                    .read<AuctionBidResultBloc>()
                    .add(AuctionBidResultLoad(auctionId)),
                emptyMsg: '',
                isEmptyList: false,
                childIsLoader: true,
                child: const AuctionBidResultContentWidget(),
              ),
            ),
          );
        },
    
    );
  }
}
