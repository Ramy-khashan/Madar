part of 'my_listings_bloc.dart';

class MyListingsState extends Equatable {
  const MyListingsState({
    this.allItems = const [],
    this.activeFilter = 'all',
    this.loadStatus = RequestStatus.init,
    this.errorMsg = '',
  });

  final List<MyListingItemModel> allItems;
  final String activeFilter;
  final RequestStatus loadStatus;
  final String errorMsg;

  List<MyListingItemModel> get filteredItems {
    if (activeFilter == 'all') return allItems;
    return allItems.where((item) {
      switch (activeFilter) {
        case 'active':
          return item.status == 'active';
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

  MyListingsState copyWith({
    List<MyListingItemModel>? allItems,
    String? activeFilter,
    RequestStatus? loadStatus,
    String? errorMsg,
  }) {
    return MyListingsState(
      allItems: allItems ?? this.allItems,
      activeFilter: activeFilter ?? this.activeFilter,
      loadStatus: loadStatus ?? this.loadStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
