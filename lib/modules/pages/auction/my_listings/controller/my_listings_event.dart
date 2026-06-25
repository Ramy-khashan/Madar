part of 'my_listings_bloc.dart';

abstract class MyListingsEvent extends Equatable {
  const MyListingsEvent();
  @override
  List<Object?> get props => [];
}

class MyListingsLoad extends MyListingsEvent {
  const MyListingsLoad();
}

class MyListingsFilterChanged extends MyListingsEvent {
  const MyListingsFilterChanged(this.filter);
  final String filter;
  @override
  List<Object?> get props => [filter];
}
