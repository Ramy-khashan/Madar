part of 'properties_map_bloc.dart';

sealed class PropertiesMapState extends Equatable {
  const PropertiesMapState();

  @override
  List<Object?> get props => [];
}

final class PropertiesMapInitial extends PropertiesMapState {}

final class PropertiesMapMarkerSelected extends PropertiesMapState {
  final int selectedIndex;
  final PropertyDetailsModel property;

  const PropertiesMapMarkerSelected({
    required this.selectedIndex,
    required this.property,
  });

  @override
  List<Object?> get props => [selectedIndex, property];
}
