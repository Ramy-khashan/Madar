import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../property_file/model/property_file_model.dart';

class UnitCard extends StatelessWidget {
  const UnitCard({
    super.key,
    required this.unit,
    required this.colors,
    this.onTap,
  });

  final UnitModel unit;
  final AppThemeColors colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isRented = unit.status == UnitStatus.rented;
    final statusColor =
        isRented ? AppColors.lightSuccessColor : AppColors.errorColor;
    final statusLabel = isRented ? 'مؤجرة' : 'شاغرة';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(16.radius),
          border: Border.all(color: colors.borderColor),
        ),
        padding: EdgeInsets.all(10.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.width,
                    vertical: 2.height,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20.radius),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: context.responsiveFontScale(10),
                      color: statusColor,
                      fontFamily: AppConstant.appFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.height),
            // Unit number box
            Center(
              child: Container(
                width: 44.width,
                height: 44.width,
                decoration: BoxDecoration(
                  color: colors.primaryBrand,
                  borderRadius: BorderRadius.circular(10.radius),
                ),
                alignment: Alignment.center,
                child: Text(
                  unit.number,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(14),
                    fontWeight: FontWeight.w700,
                    color: colors.onPrimary,
                    fontFamily: AppConstant.appHeaderFont,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.height),
            // Label
            Center(
              child: Text(
                unit.label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(12),
                  fontWeight: FontWeight.w700,
                  color: colors.textFieldTitle,
                  fontFamily: AppConstant.appHeaderFont,
                ),
              ),
            ),
            SizedBox(height: 4.height),
            // Stats row
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Stat(
                    icon: Icons.king_bed_outlined,
                    value: '${unit.rooms} غرف',
                    colors: colors,
                  ),
                  SizedBox(width: 6.width),
                  _Stat(
                    icon: Icons.straighten,
                    value: '${unit.area.toInt()} م2',
                    colors: colors,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    required this.colors,
  });

  final IconData icon;
  final String value;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12.width, color: colors.textSecondary),
        SizedBox(width: 2.width),
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(10),
            color: colors.textSecondary,
            fontFamily: AppConstant.appFont,
          ),
        ),
      ],
    );
  }
}
