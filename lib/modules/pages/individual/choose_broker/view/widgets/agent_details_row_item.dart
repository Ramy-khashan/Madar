import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/image_item.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AgentDetailsRow extends StatelessWidget {
  const AgentDetailsRow({
    super.key,
    required this.icon,
    required this.text,
    required this.colors,
  });

  final String icon;
  final String text;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageItem(icon, color: colors.textSecondary),
        SizedBox(width: 8.width),

        Text(
          text,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontFamily: AppConstant.appFont,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
