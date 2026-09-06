import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/utils/constants/app_images.dart';

class PropertiesMapMarkerIcons {
  PropertiesMapMarkerIcons._();

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

    canvas.drawPath(
      path,
      Paint()
        ..color = color.withValues(alpha: isSelected ? 0.45 : 0.28)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          isSelected ? 8.0 : 4.0,
        ),
    );
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = (isSelected ? 2.5 : 2.0) * pixelRatio,
    );

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
}
