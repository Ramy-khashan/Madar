part of 'my_wishlist_bloc.dart';

sealed class MyWishlistEvent extends Equatable {
  const MyWishlistEvent();

  @override
  List<Object> get props => [];
}
class PropertiesFilterApplied extends MyWishlistEvent {
  final PropertyFilterModel filter;

  const PropertiesFilterApplied(this.filter);

  @override
  List<Object> get props => [filter];
}