import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/model/google_map_model.dart';
import '../../../../../core/model/property_filter_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../property_details/model/property_details_model.dart';
import '../model/poperties_map_model.dart';
import 'properties_map_marker_icons.dart';

part 'properties_map_event.dart';
part 'properties_map_state.dart';
part 'mixins/properties_map_load_mixin.dart';

class PropertiesMapBloc extends Bloc<PropertiesMapEvent, PropertiesMapState>
    with PropertiesMapLoadMixin {
  PropertiesMapBloc({this.initialPosition})
    : super(const PropertiesMapState()) {
    on<LoadPropertiesMapEvent>(onLoadProperties);
    on<ToggleNearestToMeEvent>(onToggleNearestToMe);
    on<SelectMarkerEvent>(_onSelectMarker);
    on<CloseMarkerEvent>(_onCloseMarker);
    on<MapFilterApplied>(_onFilterApplied);
    on<MapSearchChanged>(_onSearchChanged);
    on<MapCameraMoved>(_onCameraMoved);
    on<MapTappedEvent>(_onMapTapped);

    add(LoadPropertiesMapEvent(position: initialPosition));
  }

  @override
  final PositionModel? initialPosition;
  Timer? _searchDebounce;

  @override
  PositionModel? cameraPosition;

  static final PositionModel _defaultPosition = PositionModel(
    latitude: 24.7136,
    longitude: 46.6753,
  );

  PositionModel get targetPosition =>
      state.mapCenter ??
      initialPosition ??
      _firstPropertyPosition ??
      _defaultPosition;

  @override
  PositionModel get queryPosition => cameraPosition ?? targetPosition;

  PositionModel? get _firstPropertyPosition {
    for (final property in state.properties) {
      final lat = property.location?.latitude;
      final lng = property.location?.longitude;
      if (lat != null && lng != null) {
        return PositionModel(latitude: lat, longitude: lng);
      }
    }
    return null;
  }

  List<PositionModel> get propertyMarkers => state.properties
      .map((property) {
        final lat = property.location?.latitude;
        final lng = property.location?.longitude;
        if (lat == null || lng == null) return null;
        return PositionModel(latitude: lat, longitude: lng);
      })
      .whereType<PositionModel>()
      .toList();

  static PropertiesMapBloc get(BuildContext context) =>
      context.read<PropertiesMapBloc>();

  static Future<({BitmapDescriptor normal, BitmapDescriptor selected})>
  buildMarkerIcons(Color brandColor) =>
      PropertiesMapMarkerIcons.buildMarkerIcons(brandColor);

  void _onSelectMarker(
    SelectMarkerEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    if (event.index < state.properties.length) {
      emit(
        state.copyWith(
          selectedIndex: event.index,
          clearPickedPosition: true,
        ),
      );
    }
  }

  void _onMapTapped(
    MapTappedEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    final propertyIndex = propertyIndexNear(event.latitude, event.longitude);
    if (propertyIndex != null) {
      emit(
        state.copyWith(
          selectedIndex: propertyIndex,
          clearPickedPosition: true,
        ),
      );
      return;
    }
    final tapped = PositionModel(
      latitude: event.latitude,
      longitude: event.longitude,
    );
    cameraPosition = tapped;
    emit(
      state.copyWith(
        selectedIndex: -1,
        pickedPosition: tapped,
      ),
    );
    add(LoadPropertiesMapEvent(position: tapped));
  }

  void _onCloseMarker(
    CloseMarkerEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    emit(state.copyWith(selectedIndex: -1));
  }

  void _onFilterApplied(
    MapFilterApplied event,
    Emitter<PropertiesMapState> emit,
  ) {
    emit(state.copyWith(filter: event.filter, selectedIndex: -1));
    add(LoadPropertiesMapEvent(position: queryPosition));
  }

  void _onSearchChanged(
    MapSearchChanged event,
    Emitter<PropertiesMapState> emit,
  ) {
    emit(state.copyWith(search: event.search));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      add(LoadPropertiesMapEvent(position: queryPosition));
    });
  }

  void _onCameraMoved(
    MapCameraMoved event,
    Emitter<PropertiesMapState> emit,
  ) {
    cameraPosition = PositionModel(
      latitude: event.latitude,
      longitude: event.longitude,
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
