import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';

class PropertyMarker extends StatelessWidget {
  const PropertyMarker({
    super.key,
    required this.colors,
    required this.isMain,
    this.isSelected = false,
  });

  final AppThemeColors colors;
  final bool isMain;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final color = isMain ? colors.primaryBrand : const Color(0xFF3B82F6);
    final pinW = isSelected ? 48.0 : 38.0;
    final pinH = isSelected ? 60.0 : 48.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: pinW,
      height: pinH,
      child: CustomPaint(
        painter: _PinPainter(color: color, isSelected: isSelected),
        child: Align(
          alignment: const Alignment(0, -0.3),
          child: Icon(
            Icons.apartment_rounded,
            color: colors.textFieldBorder,
            size: isSelected ? 36.0 : 30.0,
          ),
        ),
      ),
    );
  }
}

class _PinPainter extends CustomPainter {
  const _PinPainter({required this.color, required this.isSelected});

  final Color color;
  final bool isSelected;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = color.withValues(alpha: isSelected ? 0.45 : 0.28)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, isSelected ? 8 : 4);

    final radius = size.width / 2;
    // Circle centre sits at the top; the tip of the pin is at the bottom.
    final circleCenterY = radius;
    final tipY = size.height;

    final path = Path()
      // Start at the left tangent where the circle meets the pin body
      ..moveTo(0, circleCenterY)
      ..arcTo(
        Rect.fromCircle(center: Offset(radius, circleCenterY), radius: radius),
        pi, // 180°
        -pi, // sweep –180° (left → top → right)
        false,
      )
      // Right side curves down to the tip
      ..quadraticBezierTo(
        size.width,
        circleCenterY + (tipY - circleCenterY) * 0.55,
        radius,
        tipY,
      )
      // Left side back up from the tip
      ..quadraticBezierTo(
        0,
        circleCenterY + (tipY - circleCenterY) * 0.55,
        0,
        circleCenterY,
      )
      ..close();

    // Draw shadow first
    canvas.drawPath(path, shadowPaint);
    // Then the fill
    canvas.drawPath(path, paint);

    // White border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSelected ? 2.5 : 2.0;
    canvas.drawPath(path, borderPaint);
  }

  // ignore: non_constant_identifier_names
  static const double pi = 3.141592653589793;

  @override
  bool shouldRepaint(_PinPainter old) =>
      old.color != color || old.isSelected != isSelected;
}

// ── Marker info bottom card ────────────────────────────────────────────────
