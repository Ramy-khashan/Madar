import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import 'building_status_pill.dart';

class BuildingLabeledToggle extends StatelessWidget {
  const BuildingLabeledToggle({
    super.key,
    required this.label,
    required this.leftLabel,
    required this.rightLabel,
    required this.leftSelected,
    required this.enabled,
    required this.colors,
    required this.onLeft,
    required this.onRight,
  });

  final String label;
  final String leftLabel;
  final String rightLabel;
  final bool leftSelected;
  final bool enabled;
  final AppThemeColors colors;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontWeight: FontWeight.w600,
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appFont,
          ),
        ),
        SizedBox(height: 8.height),
        IgnorePointer(
          ignoring: !enabled,
          child: Row(
            children: [
              Expanded(
                child: BuildingStatusPill(
                  label: leftLabel,
                  selected: leftSelected,
                  colors: colors,
                  onTap: onLeft,
                ),
              ),
              SizedBox(width: 8.width),
              Expanded(
                child: BuildingStatusPill(
                  label: rightLabel,
                  selected: !leftSelected,
                  colors: colors,
                  onTap: onRight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
