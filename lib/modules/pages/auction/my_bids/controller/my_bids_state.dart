part of 'my_bids_bloc.dart';

class MyBidsState extends Equatable {
  const MyBidsState({
    this.allItems = const [],
    this.activeFilter = 'all',
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final List<MyBidItemModel> allItems;
  final String activeFilter;
  final RequestStatus loadStatus;
  final String errorMsg;

  List<MyBidItemModel> get filteredItems {
    if (activeFilter == 'all') return allItems;
    return allItems.where((item) {
      switch (activeFilter) {
        case 'live':
          return item.status == 'live';
        case 'completed':
          return item.status == 'completed';
        case 'cancelled':
          return item.status == 'cancelled';
        default:
          return true;
      }
    }).toList();
  }

  @override
  List<Object?> get props => [allItems, activeFilter, loadStatus, errorMsg];

  MyBidsState copyWith({
    List<MyBidItemModel>? allItems,
    String? activeFilter,
    RequestStatus? loadStatus,
    String? errorMsg,
  }) {
    return MyBidsState(
      allItems: allItems ?? this.allItems,
      activeFilter: activeFilter ?? this.activeFilter,
      loadStatus: loadStatus ?? this.loadStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
