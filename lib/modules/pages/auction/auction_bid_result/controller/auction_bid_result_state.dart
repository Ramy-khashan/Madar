part of 'auction_bid_result_bloc.dart';

class AuctionBidResultState extends Equatable {
  const AuctionBidResultState({
    this.result,
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final AuctionBidResultModel? result;
  final RequestStatus loadStatus;
  final String errorMsg;

  @override
  List<Object?> get props => [result, loadStatus, errorMsg];

  AuctionBidResultState copyWith({
    AuctionBidResultModel? result,
    RequestStatus? loadStatus,
    String? errorMsg,
  }) {
    return AuctionBidResultState(
      result: result ?? this.result,
      loadStatus: loadStatus ?? this.loadStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
