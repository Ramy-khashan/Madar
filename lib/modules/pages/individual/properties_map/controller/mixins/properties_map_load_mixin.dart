part of '../properties_map_bloc.dart';

mixin PropertiesMapLoadMixin on Bloc<PropertiesMapEvent, PropertiesMapState> {
  PositionModel? get initialPosition;
  PositionModel? get cameraPosition;
  set cameraPosition(PositionModel? value);
  PositionModel get queryPosition;
  void onPropertiesFetchCompleted();

  Future<void> onLoadProperties(
    LoadPropertiesMapEvent event,
    Emitter<PropertiesMapState> emit,
  ) async {
    try {
      emit(state.copyWith(status: RequestStatus.loading));

      final position = event.position ?? queryPosition;
      final List<PropertyDetailsModel> fetchedProperties = [];

      int page = 1;
      bool hasNext = true;
      String? errorMsg;

      while (hasNext && page <= 20) {
        final query = mapQuery(position, page);
        final response = await sl.get<ApiConsumer>().get(
          EndPoints.propertiesMap,
          queryParameters: query,
        );

        hasNext = false;
        response.fold(
          (failedResponse) {
            errorMsg = failedResponse;
          },
          (successResponse) {
            final result = PropertiesMapResponseModel.fromJson(
              successResponse.response,
            );
            fetchedProperties.addAll(result.properties);
            final pagination = result.pagination;
            final currentPage = pagination?.page ?? page;
            hasNext =
                pagination?.hasNext == true ||
                ((pagination?.totalPages ?? currentPage) > currentPage);
            page = currentPage + 1;
          },
        );

        if (errorMsg != null) break;
      }

      if (errorMsg != null) {
        emit(
          state.copyWith(status: RequestStatus.failed, errorMsg: errorMsg),
        );
        return;
      }

      final merged = _mergePropertiesById(state.properties, fetchedProperties);
      final picked = state.pickedPosition;
      final nearPropertyIndex = picked == null
          ? null
          : propertyIndexNear(
              picked.position.latitude,
              picked.position.longitude,
              properties: merged,
            );
      final keepSelected = state.selectedIndex >= 0 &&
          state.selectedIndex < merged.length;
      emit(
        state.copyWith(
          status: RequestStatus.success,
          properties: merged,
          mapCenter: position,
          selectedIndex: nearPropertyIndex ?? (keepSelected ? state.selectedIndex : -1),
          clearPickedPosition: nearPropertyIndex != null,
        ),
      );
      onPropertiesFetchCompleted();
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }

  Future<void> onToggleNearestToMe(
    ToggleNearestToMeEvent event,
    Emitter<PropertiesMapState> emit,
  ) async {
    if (!event.value) {
      emit(state.copyWith(isNearestToMe: false, clearPickedPosition: true));
      add(LoadPropertiesMapEvent(position: initialPosition));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      emit(state.copyWith(isNearestToMe: false));
      AppToast(AppStrings.locationPermissionDenied, isError: true);
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      emit(state.copyWith(isNearestToMe: false));
      AppToast(AppStrings.locationPermissionDenied, isError: true);
      await Geolocator.openAppSettings();
      return;
    }

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(state.copyWith(isNearestToMe: false));
      AppToast(AppStrings.locationServiceDisabled, isError: true);
      await Geolocator.openLocationSettings();
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      final userPosition = PositionModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      cameraPosition = userPosition;
      emit(
        state.copyWith(
          isNearestToMe: true,
          pickedPosition: userPosition,
          selectedIndex: -1,
        ),
      );
      add(LoadPropertiesMapEvent(position: userPosition));
    } catch (e) {
      emit(state.copyWith(isNearestToMe: false));
      AppToast(AppStrings.somethingWentWrong, isError: true);
    }
  }

  List<PropertyDetailsModel> _mergePropertiesById(
    List<PropertyDetailsModel> existing,
    List<PropertyDetailsModel> incoming,
  ) {
    final merged = List<PropertyDetailsModel>.from(existing);
    final existingIds = <String>{
      for (final property in merged)
        if (_propertyId(property) != null) _propertyId(property)!,
    };

    for (final property in incoming) {
      final id = _propertyId(property);
      if (id == null || existingIds.contains(id)) continue;
      existingIds.add(id);
      merged.add(property);
    }
    return merged;
  }

  String? _propertyId(PropertyDetailsModel property) {
    final id = property.propertyId?.toString().trim();
    if (id == null || id.isEmpty) return null;
    return id;
  }

  int? propertyIndexNear(
    double latitude,
    double longitude, {
    List<PropertyDetailsModel>? properties,
  }) {
    const thresholdMeters = 30.0;
    final items = properties ?? state.properties;
    for (var i = 0; i < items.length; i++) {
      final loc = items[i].location;
      final lat = loc?.latitude;
      final lng = loc?.longitude;
      if (lat == null || lng == null) continue;
      final distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        lat,
        lng,
      );
      if (distance <= thresholdMeters) return i;
    }
    return null;
  }

  Map<String, dynamic> mapQuery(PositionModel position, int page) {
    final lat = position.position.latitude;
    final lng = position.position.longitude;
    if (state.filter != null) {
      return state.filter!.toMapQuery(
        latitude: lat,
        longitude: lng,
        page: page,
        title: state.search,
      );
    }
    return {
      'latitude': lat,
      'longitude': lng,
      'page': page,
      'limit': 50,
      if (state.search.trim().isNotEmpty) 'title': state.search.trim(),
    };
  }
}
