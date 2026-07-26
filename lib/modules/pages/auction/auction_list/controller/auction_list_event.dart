part of 'auction_list_bloc.dart';

abstract class AuctionListEvent extends Equatable {
  const AuctionListEvent();
  @override
  List<Object?> get props => [];
}

class AuctionListLoad extends AuctionListEvent {
  const AuctionListLoad({this.page = 1, this.isLoadMore = false});

  final int page;
  final bool isLoadMore;

  @override
  List<Object?> get props => [page, isLoadMore];
}

class AuctionListFilterChanged extends AuctionListEvent {
  final AuctionFilterTab filter;
  const AuctionListFilterChanged(this.filter);
  @override
  List<Object?> get props => [filter];
}
