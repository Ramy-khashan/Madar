part of 'properties_map_bloc.dart';

sealed class PropertiesMapEvent extends Equatable {
  const PropertiesMapEvent();

  @override
  List<Object?> get props => [];
}

/// Fetches properties from `properties/map` for [position] (or the map's
/// default position when null), looping through pagination until all pages
/// are collected.
final class LoadPropertiesMapEvent extends PropertiesMapEvent {
  final PositionModel? position;
  const LoadPropertiesMapEvent({this.position});

  @override
  List<Object?> get props => [position];
}

/// Toggles "عرض الاقرب لمنطقتي" — when enabled, requests location
/// permission, fetches the user's current position and reloads the
/// properties around it.
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
