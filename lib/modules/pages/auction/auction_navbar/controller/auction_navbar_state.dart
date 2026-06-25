part of 'auction_navbar_bloc.dart';

class AuctionNavbarState extends Equatable {
  const AuctionNavbarState({this.selectedIndex = 0});
  final int selectedIndex;
  @override
  List<Object> get props => [selectedIndex];
  AuctionNavbarState copyWith({int? selectedIndex}) {
    return AuctionNavbarState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
