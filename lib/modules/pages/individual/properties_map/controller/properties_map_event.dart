part of 'properties_map_bloc.dart';

sealed class PropertiesMapEvent extends Equatable {
  const PropertiesMapEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPropertiesMapEvent extends PropertiesMapEvent {
  final PositionModel? position;
  const LoadPropertiesMapEvent({this.position});

  @override
  List<Object?> get props => [position];
}

final class ToggleNearestToMeEvent extends PropertiesMapEvent {
  final bool value;
  const ToggleNearestToMeEvent(this.value);

  @override
  List<Object?> get props => [value];
}

final class SelectMarkerEvent extends PropertiesMapEvent {
  final int index;
  const SelectMarkerEvent(this.index);

  @override
  List<Object?> get props => [index];
}

final class CloseMarkerEvent extends PropertiesMapEvent {
  const CloseMarkerEvent();
}

final class MapFilterApplied extends PropertiesMapEvent {
  const MapFilterApplied(this.filter);
  final PropertyFilterModel filter;

  @override
  List<Object?> get props => [filter];
}

final class MapSearchChanged extends PropertiesMapEvent {
  const MapSearchChanged(this.search);
  final String search;

  @override
  List<Object?> get props => [search];
}

final class MapCameraMoved extends PropertiesMapEvent {
  const MapCameraMoved(this.latitude, this.longitude);
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

final class MapCameraIdle extends PropertiesMapEvent {
  const MapCameraIdle();
}

final class MapTappedEvent extends PropertiesMapEvent {
  const MapTappedEvent(this.latitude, this.longitude);
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}
