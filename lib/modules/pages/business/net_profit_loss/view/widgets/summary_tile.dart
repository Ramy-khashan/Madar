import 'package:flutter/material.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.captionColor,
  });

  final String label;
  final String value;
  final Color color;
  final Color captionColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(24),
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(12),
            color: captionColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
