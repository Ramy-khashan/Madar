part of 'my_properties_bloc.dart';

sealed class MyPropertiesEvent extends Equatable {
  const MyPropertiesEvent();

  @override
  List<Object> get props => [];
}

final class MyPropertiesLoad extends MyPropertiesEvent {
  final int page;
  final bool isLoadMore;
  const MyPropertiesLoad({this.page = 1, this.isLoadMore = false});
  @override
  List<Object> get props => [page, isLoadMore];
}

final class MyPropertiesFilterApplied extends MyPropertiesEvent {
  const MyPropertiesFilterApplied(this.filter);
  final PropertyFilterModel filter;
  @override
  List<Object> get props => [filter];
}
