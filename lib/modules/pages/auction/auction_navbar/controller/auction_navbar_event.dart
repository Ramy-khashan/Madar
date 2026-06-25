part of 'auction_navbar_bloc.dart';

sealed class AuctionNavbarEvent extends Equatable {
  const AuctionNavbarEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends AuctionNavbarEvent {
  final int index;
  const ChangePageEvent(this.index);
  @override
  List<Object> get props => [index];
}