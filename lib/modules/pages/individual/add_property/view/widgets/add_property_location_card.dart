import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AddPropertyLocationCard extends StatelessWidget {
  const AddPropertyLocationCard({
    super.key,
    required this.location,
    required this.tc,
  });
  final String location;
  final AppThemeColors tc;

  @override
  Widget build(BuildContext context) {
    final lines = location.split('\n');
    final line1 = lines.isNotEmpty ? lines[0] : location;
    final line2 = lines.length > 1 ? lines[1] : null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.width, vertical: 12.height),
      decoration: BoxDecoration(
        color: tc.primaryBrand.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tc.primaryBrand.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.height),
            child: Icon(
              Icons.location_on_rounded,
              color: tc.primaryBrand,
              size: 20,
            ),
          ),
          SizedBox(width: 10.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line1,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(13),
                    fontWeight: FontWeight.w600,
                    color: tc.textPrimary,
                  ),
                ),
                if (line2 != null && line2.isNotEmpty) ...[
                  SizedBox(height: 2.height),
                  Text(
                    line2,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(12),
                      color: tc.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(Icons.edit, color: tc.primaryBrand, size: 20),
        ],
      ),
    );
  }
}
