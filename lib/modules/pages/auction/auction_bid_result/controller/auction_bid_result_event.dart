part of 'auction_bid_result_bloc.dart';

abstract class AuctionBidResultEvent extends Equatable {
  const AuctionBidResultEvent();
  @override
  List<Object?> get props => [];
}

class AuctionBidResultLoad extends AuctionBidResultEvent {
  final String auctionId;
  const AuctionBidResultLoad(this.auctionId);
  @override
  List<Object?> get props => [auctionId];
}

class AuctionBidResultCountdownTick extends AuctionBidResultEvent {
  const AuctionBidResultCountdownTick();
}
