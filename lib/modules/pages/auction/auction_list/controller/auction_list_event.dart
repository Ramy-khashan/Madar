part of 'auction_list_bloc.dart';

abstract class AuctionListEvent extends Equatable {
  const AuctionListEvent();
  @override
  List<Object?> get props => [];
}

class AuctionListLoad extends AuctionListEvent {
  const AuctionListLoad();
}

class AuctionListFilterChanged extends AuctionListEvent {
  final AuctionFilterTab filter;
  const AuctionListFilterChanged(this.filter);
  @override
  List<Object?> get props => [filter];
}
