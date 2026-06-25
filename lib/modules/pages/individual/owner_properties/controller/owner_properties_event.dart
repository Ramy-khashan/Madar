part of 'owner_properties_bloc.dart';

abstract class OwnerPropertiesEvent extends Equatable {
  const OwnerPropertiesEvent();

  @override
  List<Object?> get props => [];
}

class OwnerPropertiesLoad extends OwnerPropertiesEvent {
  const OwnerPropertiesLoad();
}

class OwnerPropertiesFilterApplied extends OwnerPropertiesEvent {
  const OwnerPropertiesFilterApplied(this.filter);
  final PropertyFilterModel filter;
  @override
  List<Object?> get props => [filter];
}
