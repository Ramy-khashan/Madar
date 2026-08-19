import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/connection/concept/end_points.dart';
import '../../../../../core/connection/interfaces/api_consumer.dart';
import '../../../../../core/model/google_map_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/common_fun.dart';
import '../../../../../core/utils/functions/service_locator.dart';
import '../../property_details/model/property_details_model.dart';
import '../model/poperties_map_model.dart';

part 'properties_map_event.dart';
part 'properties_map_state.dart';

class PropertiesMapBloc extends Bloc<PropertiesMapEvent, PropertiesMapState> {
  PropertiesMapBloc({this.initialPosition})
    : super(const PropertiesMapState()) {
    on<LoadPropertiesMapEvent>(_onLoadProperties);
    on<ToggleNearestToMeEvent>(_onToggleNearestToMe);
    on<SelectMarkerEvent>(_onSelectMarker);
    on<CloseMarkerEvent>(_onCloseMarker);

    add(LoadPropertiesMapEvent(position: initialPosition));
  }

  final PositionModel? initialPosition;

  /// Fallback position used when no initial/user position is available yet.
  static final PositionModel _defaultPosition = PositionModel(
    latitude: 24.7136,
    longitude: 46.6753,
  );

  PositionModel get targetPosition =>
      state.mapCenter ?? initialPosition ?? _firstPropertyPosition ?? _defaultPosition;

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

  /// All markers built from the fetched properties (skips items with no
  /// location data).
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

  // ---------------------------------------------------------------------------
  // Canvas-based marker icon generation — no widget tree dependency
  // ---------------------------------------------------------------------------

  static final Map<
    int,
    Future<({BitmapDescriptor normal, BitmapDescriptor selected})>
  >
  _iconCache = {};

  static Future<({BitmapDescriptor normal, BitmapDescriptor selected})>
  buildMarkerIcons(Color brandColor) {
    final key = brandColor.toARGB32();
    return _iconCache.putIfAbsent(key, () async {
      final normal = await _drawPinMarker(
        color: brandColor,
        iconColor: const Color(0xFF1B3553),
        width: 38.0,
        height: 48.0,
        isSelected: false,
      );
      final selected = await _drawPinMarker(
        color: brandColor,
        iconColor: const ui.Color.fromARGB(115, 31, 60, 94),
        width: 48.0,
        height: 60.0,
        isSelected: true,
      );
      return (normal: normal, selected: selected);
    });
  }

  /// Replicates [_PinPainter] on a raw canvas so the BitmapDescriptor matches
  /// the Flutter widget exactly: circle-top + pointed-bottom, apartment icon.
  static Future<BitmapDescriptor> _drawPinMarker({
    required Color color,
    required Color iconColor,
    required double width,
    required double height,
    required bool isSelected,
  }) async {
    const double pixelRatio = 3.0;
    final double pw = width * pixelRatio;
    final double ph = height * pixelRatio;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final double radius = pw / 2;
    final double circleCenterY = radius;
    final double tipY = ph;

    // Same path as _PinPainter
    final path = Path()
      ..moveTo(0, circleCenterY)
      ..arcTo(
        Rect.fromCircle(center: Offset(radius, circleCenterY), radius: radius),
        math.pi,
        -math.pi,
        false,
      )
      ..quadraticBezierTo(
        pw,
        circleCenterY + (tipY - circleCenterY) * 0.55,
        radius,
        tipY,
      )
      ..quadraticBezierTo(
        0,
        circleCenterY + (tipY - circleCenterY) * 0.55,
        0,
        circleCenterY,
      )
      ..close();

    // Shadow
    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: isSelected ? 0.45 : 0.28)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          isSelected ? 8.0 : 4.0,
        ),
    );

    // Fill
    canvas.drawPath(path, Paint()..color = color);

    // White border
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = (isSelected ? 2.5 : 2.0) * pixelRatio,
    );

    // Icon — Align(Alignment(0, -0.3)) → center at (width/2, height × 0.35)
    // final tp = TextPainter(textDirection: TextDirection.ltr)
    //   ..text = TextSpan(
    //     text: String.fromCharCode(Icons.api_outlined.codePoint),
    //     style: TextStyle(
    //       fontSize: (isSelected ? 36.0 : 30.0) * pixelRatio,
    //       fontFamily: 'MaterialIcons',
    //       color: iconColor,
    //     ),
    //   )
    //   ..layout();
    // tp.paint(
    //   canvas,
    //   Offset(pw / 2 - tp.width / 2, ph * 0.35 - tp.height / 2),
    // );
    final logo = await _loadAssetImage(AppImages.mapPropertyIcon);

    final iconSize = (isSelected ? 56.0 : 50.0) * pixelRatio;

    final dstRect = Rect.fromCenter(
      center: Offset(pw / 2, ph * 0.35),
      width: iconSize,
      height: iconSize,
    );

    final srcRect = Rect.fromLTWH(
      0,
      0,
      logo.width.toDouble(),
      logo.height.toDouble(),
    );

    canvas.drawImageRect(
      logo,
      srcRect,
      dstRect,
      Paint()..filterQuality = FilterQuality.high,
    );
    final picture = recorder.endRecording();
    final image = await picture.toImage(pw.toInt(), ph.toInt());
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  static Future<ui.Image> _loadAssetImage(String asset) async {
    final ByteData data = await rootBundle.load(asset);

    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());

    final frame = await codec.getNextFrame();
    return frame.image;
  }
  // ---------------------------------------------------------------------------
  // Event handlers
  // ---------------------------------------------------------------------------

  Future<void> _onLoadProperties(
    LoadPropertiesMapEvent event,
    Emitter<PropertiesMapState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: RequestStatus.loading,
          properties: const [],
          selectedIndex: -1,
        ),
      );

      final position = event.position ?? initialPosition;
      final List<PropertyDetailsModel> allProperties = [];

      int page = 1;
      bool hasNext = true;
      String? errorMsg;

      while (hasNext && page <= 20) {
        final response = await sl.get<ApiConsumer>().get(
          EndPoints.propertiesMap,
          queryParameters: {
            if (position != null) 'latitude': position.position.latitude,
            if (position != null) 'longitude': position.position.longitude,
            'page': page,
          },
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
            allProperties.addAll(result.properties);
            hasNext = result.pagination?.hasNext ?? false;
            page = (result.pagination?.page ?? page) + 1;
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

      emit(
        state.copyWith(
          status: RequestStatus.success,
          properties: allProperties,
          mapCenter: position,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.failed,
          errorMsg: AppStrings.somethingWentWrong,
        ),
      );
    }
  }

  Future<void> _onToggleNearestToMe(
    ToggleNearestToMeEvent event,
    Emitter<PropertiesMapState> emit,
  ) async {
    emit(state.copyWith(isNearestToMe: event.value));

    if (!event.value) {
      add(LoadPropertiesMapEvent(position: initialPosition));
      return;
    }

    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(isNearestToMe: false));
        AppToast(AppStrings.locationServiceDisabled, isError: true);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        emit(state.copyWith(isNearestToMe: false));
        AppToast(AppStrings.locationPermissionDenied, isError: true);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      add(
        LoadPropertiesMapEvent(
          position: PositionModel(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isNearestToMe: false));
      AppToast(AppStrings.somethingWentWrong, isError: true);
    }
  }

  void _onSelectMarker(
    SelectMarkerEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    if (event.index < state.properties.length) {
      emit(state.copyWith(selectedIndex: event.index));
    }
  }

  void _onCloseMarker(
    CloseMarkerEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    emit(state.copyWith(selectedIndex: -1));
  }
}

