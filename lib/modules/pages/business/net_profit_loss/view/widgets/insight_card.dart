import 'package:flutter/material.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class InsightCard extends StatelessWidget {
  const InsightCard({
    super.key,
    required this.message,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
  });

  final String message;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.radius),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        message,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: context.responsiveFontScale(14),
          color: textColor,
          height: 1.5,
        ),
      ),
    );
  }
}
