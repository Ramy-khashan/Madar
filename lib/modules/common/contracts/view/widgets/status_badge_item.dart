
import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
class ContractStatusBadge extends StatelessWidget {
  const ContractStatusBadge({super.key, required this.status});
  final String status;

  static const _colors = {
    'active': Color(0xFF00875A),
    'underReview': Color(0xFFE65100),
    'completed' : Color(0xFF566981),
  };

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      'active' => AppStrings.activeStatus,
      'underReview' => AppStrings.underReviewStatus,
      'completed' => AppStrings.completedStatus,
      _ => status,
    };
    final color = _colors[status]!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.responsiveFontScale(11),
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
