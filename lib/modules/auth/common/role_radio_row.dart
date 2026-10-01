import 'package:flutter/material.dart';
import '../../../config/theme/app_theme_colors.dart';
import '../../../core/utils/constants/app_constant.dart';
import '../../../core/utils/functions/responsive.dart';

class RoleRadioRow extends StatelessWidget {
  const RoleRadioRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.height),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? colors.primaryBrand : colors.textSecondary,
              size: 22.width,
            ),
            SizedBox(width: 8.width),
            Text(
              label,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.textPrimary,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
