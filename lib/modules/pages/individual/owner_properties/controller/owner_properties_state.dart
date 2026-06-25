part of 'owner_properties_bloc.dart';

abstract class OwnerPropertiesState extends Equatable {
  const OwnerPropertiesState();

  @override
  List<Object?> get props => [];
}

class OwnerPropertiesInitial extends OwnerPropertiesState {}

class OwnerPropertiesLoaded extends OwnerPropertiesState {
  const OwnerPropertiesLoaded({
    required this.owner,
    required this.properties,
    this.filter = const PropertyFilterModel(),
  });

  final PropertyListingUserModel owner;
  final List<PropertiesItemModel> properties;
  final PropertyFilterModel filter;

  @override
  List<Object?> get props => [owner, properties, filter];
}
