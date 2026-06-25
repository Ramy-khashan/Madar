part of 'auction_list_bloc.dart';

class AuctionListState extends Equatable {
  const AuctionListState({
    this.allItems = const [],
    this.activeFilter = AuctionFilterTab.all,
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final List<AuctionItemModel> allItems;
  final AuctionFilterTab activeFilter;
  final RequestStatus loadStatus;
  final String errorMsg;

  List<AuctionItemModel> get filteredItems {
    if (activeFilter == AuctionFilterTab.all) return allItems;
    return allItems.where((item) {
      switch (activeFilter) {
        case AuctionFilterTab.live:
          return item.status == AuctionStatus.live;
        case AuctionFilterTab.upcoming:
          return item.status == AuctionStatus.upcoming;
        case AuctionFilterTab.ended:
          return item.status == AuctionStatus.ended;
        default:
          return true;
      }
    }).toList();
  }

  @override
  List<Object?> get props => [allItems, activeFilter, loadStatus, errorMsg];

  AuctionListState copyWith({
    List<AuctionItemModel>? allItems,
    AuctionFilterTab? activeFilter,
    RequestStatus? loadStatus,
    String? errorMsg,
  }) {
    return AuctionListState(
      allItems: allItems ?? this.allItems,
      activeFilter: activeFilter ?? this.activeFilter,
      loadStatus: loadStatus ?? this.loadStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
