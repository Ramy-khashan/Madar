import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../../../../../core/utils/functions/responsive.dart';
import '../../../../../core/utils/functions/translation.dart';

class ContractStatusBadge extends StatelessWidget {
  const ContractStatusBadge({super.key, required this.status, this.label});
  final String status;
  final String? label;

  static const _colors = {
    'ACTIVE': Color(0xFF00875A),
    'PENDING': Color(0xFFE65100),
    'UNDERREVIEW': Color(0xFFE65100),
    'UNDER_REVIEW': Color(0xFFE65100),
    'COMPLETED': Color(0xFF566981),
    'REJECTED': Color(0xFFD92D20),
    'CANCELLED': Color(0xFFD92D20),
  };

  String get _normalized =>
      status.replaceAll(' ', '_').replaceAll('-', '_').toUpperCase();

  @override
  Widget build(BuildContext context) {
    final key = _normalized;
    final color = _colors[key] ?? const Color(0xFFE65100);
    final text = (label ?? '').trim().isNotEmpty
        ? label!
        : switch (key) {
            'ACTIVE' => AppStrings.activeStatus,
            'PENDING' => AppStrings.pendingStatus,
            'UNDERREVIEW' || 'UNDER_REVIEW' => AppStrings.underReviewStatus,
            'COMPLETED' => AppStrings.completedStatus,
            'REJECTED' => AppStrings.rejectedStatus,
            'CANCELLED' => AppStrings.cancelledTab,
            _ => status.transIfExists,
          };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.width, vertical: 4.height),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.radius),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: context.responsiveFontScale(11),
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
