part of 'my_wishlist_bloc.dart';

sealed class MyWishlistState extends Equatable {
  const MyWishlistState();
  
  @override
  List<Object> get props => [];
}

final class MyWishlistInitial extends MyWishlistState {}
