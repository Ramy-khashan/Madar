part of 'auction_list_bloc.dart';

class AuctionListState extends Equatable {
  const AuctionListState({
    this.allItems = const [],
    this.activeFilter = AuctionFilterTab.all,
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
    this.isLoadMore = false,
    this.totalCount = 0,
  });

  final List<AuctionItemModel> allItems;
  final AuctionFilterTab activeFilter;
  final RequestStatus loadStatus;
  final String errorMsg;
  final bool isLoadMore;
  final int totalCount;

  @override
  List<Object?> get props => [
    allItems, activeFilter, loadStatus, errorMsg, isLoadMore, totalCount,
  ];

  AuctionListState copyWith({
    List<AuctionItemModel>? allItems,
    AuctionFilterTab? activeFilter,
    RequestStatus? loadStatus,
    String? errorMsg,
    bool? isLoadMore,
    int? totalCount,
  }) {
    return AuctionListState(
      allItems:     allItems     ?? this.allItems,
      activeFilter: activeFilter ?? this.activeFilter,
      loadStatus:   loadStatus   ?? this.loadStatus,
      errorMsg:     errorMsg     ?? this.errorMsg,
      isLoadMore:   isLoadMore   ?? this.isLoadMore,
      totalCount:   totalCount   ?? this.totalCount,
    );
  }
}
