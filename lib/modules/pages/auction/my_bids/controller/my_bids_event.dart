part of 'my_bids_bloc.dart';

abstract class MyBidsEvent extends Equatable {
  const MyBidsEvent();
  @override
  List<Object?> get props => [];
}

class MyBidsLoad extends MyBidsEvent {
  const MyBidsLoad();
}

class MyBidsFilterChanged extends MyBidsEvent {
  const MyBidsFilterChanged(this.filter);
  final String filter;
  @override
  List<Object?> get props => [filter];
}
