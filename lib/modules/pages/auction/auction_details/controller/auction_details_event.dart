part of 'auction_details_bloc.dart';

abstract class AuctionDetailsEvent extends Equatable {
  const AuctionDetailsEvent();
  @override
  List<Object?> get props => [];
}

class AuctionDetailsLoad extends AuctionDetailsEvent {
  final String auctionId;
  const AuctionDetailsLoad(this.auctionId);
  @override
  List<Object?> get props => [auctionId];
}

class AuctionDetailsPlaceBid extends AuctionDetailsEvent {
  const AuctionDetailsPlaceBid();
}
