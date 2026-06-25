part of 'my_property_details_bloc.dart';

sealed class MyPropertyDetailsEvent extends Equatable {
  const MyPropertyDetailsEvent();

  @override
  List<Object> get props => [];
}

final class MyPropertyDetailsLoad extends MyPropertyDetailsEvent {
  final String propertyId;
  const MyPropertyDetailsLoad(this.propertyId);

  @override
  List<Object> get props => [propertyId];
}

final class MyPropertyDetailsToggleBookmark extends MyPropertyDetailsEvent {
  const MyPropertyDetailsToggleBookmark();
}

final class MyPropertyDetailsImageViewStarted extends MyPropertyDetailsEvent {
  const MyPropertyDetailsImageViewStarted({required this.imageCount});
  final int imageCount;
  @override
  List<Object> get props => [imageCount];
}

final class MyPropertyDetailsPageChanged extends MyPropertyDetailsEvent {
  const MyPropertyDetailsPageChanged({required this.page});
  final int page;
  @override
  List<Object> get props => [page];
}

final class _MyPropertyDetailsAutoScrollTick extends MyPropertyDetailsEvent {
  const _MyPropertyDetailsAutoScrollTick();
}
