import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';

class BuildingRowDivider extends StatelessWidget {
  const BuildingRowDivider({super.key, required this.colors});

  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, color: colors.borderColor);
  }
}
