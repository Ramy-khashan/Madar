part of 'properties_map_bloc.dart';

sealed class PropertiesMapEvent extends Equatable {
  const PropertiesMapEvent();

  @override
  List<Object?> get props => [];
}

final class NavigateToPositionEvent extends PropertiesMapEvent {
  final PositionModel position;
  const NavigateToPositionEvent(this.position);

  @override
  List<Object?> get props => [position];
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
