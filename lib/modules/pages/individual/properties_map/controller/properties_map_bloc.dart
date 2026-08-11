import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/model/google_map_model.dart';
import '../../../../../core/utils/constants/app_images.dart';
import '../../property_details/model/property_details_buyer_model.dart';
import '../../property_details/model/property_details_model.dart';

part 'properties_map_event.dart';
part 'properties_map_state.dart';

class PropertiesMapBloc extends Bloc<PropertiesMapEvent, PropertiesMapState> {
  PropertiesMapBloc({this.initialPosition}) : super(PropertiesMapInitial()) {
    on<NavigateToPositionEvent>(_onNavigateToPosition);
    on<SelectMarkerEvent>(_onSelectMarker);
    on<CloseMarkerEvent>(_onCloseMarker);
  }

  final PositionModel? initialPosition;

  PositionModel get targetPosition => initialPosition ?? propertyMarkers.first;

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

  void _onNavigateToPosition(
    NavigateToPositionEvent event,
    Emitter<PropertiesMapState> emit,
  ) {}

  void _onSelectMarker(
    SelectMarkerEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    if (event.index < sampleProperties.length) {
      emit(
        PropertiesMapMarkerSelected(
          selectedIndex: event.index,
          property: sampleProperties[event.index],
        ),
      );
    }
  }

  void _onCloseMarker(
    CloseMarkerEvent event,
    Emitter<PropertiesMapState> emit,
  ) {
    emit(PropertiesMapInitial());
  }

  // ---------------------------------------------------------------------------
  // Static sample data
  // ---------------------------------------------------------------------------

  // static  final _defaultAdvertiser = PropertyOwner(
  //   fullName: 'أحمد محمد',
  //   role: 'وسيط عقاري',
  //   isVerified: true,
  //   falLicenseNumber: '2023456789',
  //   adLicenseNumber: '1234567890',
  //   totalProperties: 12,
  // );

  // static  final_defaultRentInfo = RentInstallmentInfoModel(
  //     isEligible: true,
  //     annualRentValue: 120000,
  //     minMonthlyInstallment: 2500,
  //     providersCount: 3,
  //   );

  //   static const _defaultInsuranceInfo = InsuranceInfoModel(
  //     isInsured: true,
  //     availableTypes: ['شامل', 'جزئي'],
  //     companiesCount: 5,
  //   );

  static final List<PositionModel> propertyMarkers = [
    PositionModel(latitude: 24.7136, longitude: 46.6753),
    PositionModel(latitude: 24.7180, longitude: 46.6700),
    PositionModel(latitude: 24.7095, longitude: 46.6810),
    PositionModel(latitude: 24.7060, longitude: 46.6650),
    PositionModel(latitude: 24.7210, longitude: 46.6780),
  ];

  static final List<PropertyDetailsModel> sampleProperties = [];
}
