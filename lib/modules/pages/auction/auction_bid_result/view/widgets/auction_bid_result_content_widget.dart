import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/auction_bid_result_bloc.dart';
import '../../model/auction_bid_result_model.dart';
import 'waiting_view.dart';
import 'won_view.dart';
import 'outbid_view.dart';

class AuctionBidResultContentWidget extends StatelessWidget {
  const AuctionBidResultContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionBidResultBloc, AuctionBidResultState>(
      builder: (context, state) {
        final result = state.result;
        if (result == null) return const SizedBox();
        return switch (result.status) {
          BidResultStatus.waiting => WaitingView(result: result),
          BidResultStatus.won => WonView(result: result),
          BidResultStatus.outbid => OutbidView(result: result),
        };
      },
    );
  }
}
