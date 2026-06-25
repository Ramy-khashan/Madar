part of 'my_properties_bloc.dart';

sealed class MyPropertiesEvent extends Equatable {
  const MyPropertiesEvent();

  @override
  List<Object> get props => [];
}

final class MyPropertiesLoad extends MyPropertiesEvent {
  const MyPropertiesLoad();
}

final class MyPropertiesFilterApplied extends MyPropertiesEvent {
  const MyPropertiesFilterApplied(this.filter);
  final PropertyFilterModel filter;
  @override
  List<Object> get props => [filter];
}
