part of 'properties_bloc.dart';

abstract class PropertiesEvent extends Equatable {
  const PropertiesEvent();

  @override
  List<Object?> get props => [];
}

class PropertiesLoad extends PropertiesEvent {
  final bool isLoadMore;
  final int page;
  const PropertiesLoad({this.isLoadMore = false, this.page = 1});
  @override
  List<Object?> get props => [isLoadMore];
}

class PropertiesFilterApplied extends PropertiesEvent {
  const PropertiesFilterApplied(this.filter);
  final PropertyFilterModel filter;
  @override
  List<Object?> get props => [filter];
}
