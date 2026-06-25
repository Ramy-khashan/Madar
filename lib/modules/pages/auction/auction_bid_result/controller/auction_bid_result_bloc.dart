import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constants/app_enums.dart';
import '../model/auction_bid_result_model.dart';

part 'auction_bid_result_event.dart';
part 'auction_bid_result_state.dart';

class AuctionBidResultBloc
    extends Bloc<AuctionBidResultEvent, AuctionBidResultState> {
  AuctionBidResultBloc() : super(const AuctionBidResultState()) {
    on<AuctionBidResultLoad>(_onLoad);
    on<AuctionBidResultCountdownTick>(_onTick);
  }

  Timer? _timer;

  static AuctionBidResultBloc get(BuildContext context) =>
      BlocProvider.of<AuctionBidResultBloc>(context);

  Future<void> _onLoad(
    AuctionBidResultLoad event,
    Emitter<AuctionBidResultState> emit,
  ) async {
    emit(state.copyWith(loadStatus: RequestStatus.loading));
     final result = AuctionBidResultModel(
      auctionId: event.auctionId,
      propertyTitle: 'شقة فاخرة في الملقا',
      propertyLocation: 'الرياض - حي الملقا',
      bidAmount: 860000,
      status: BidResultStatus.waiting,
      countdownSeconds: 5,
    );
    emit(state.copyWith(
      loadStatus: RequestStatus.success,
      result: result,
    ));
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const AuctionBidResultCountdownTick());
    });
  }

  void _onTick(
    AuctionBidResultCountdownTick event,
    Emitter<AuctionBidResultState> emit,
  ) {
    if (state.result == null) return;
    final current = state.result!.countdownSeconds;
    if (current <= 0) {
      _timer?.cancel();
      // Simulate result: won
      emit(state.copyWith(
        result: state.result!.copyWith(status: BidResultStatus.won),
      ));
      return;
    }
    emit(state.copyWith(
      result: state.result!.copyWith(countdownSeconds: current - 1),
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
