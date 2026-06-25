import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';

/// An editable row field with a leading edit icon and a trailing icon
class UnitInfoRow extends StatelessWidget {
  const UnitInfoRow({
    super.key,
    required this.label,
    required this.value,
    required this.trailingIcon,
    required this.colors,
    this.controller,
    this.isEditable = true,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String value;
  final IconData trailingIcon;
  final AppThemeColors colors;
  final TextEditingController? controller;
  final bool isEditable;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.width,
        vertical: 12.height,
      ),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(14.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Row(
        children: [
          // Edit icon
          if (isEditable)
            Icon(
              Icons.edit_outlined,
              size: 18.width,
              color: colors.textSecondary,
            ),
          SizedBox(width: 8.width),
          // Label & value column (RTL: value on left, label on right)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(12),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
                SizedBox(height: 2.height),
                controller != null
                    ? TextField(
                        controller: controller,
                        textAlign: TextAlign.end,
                        keyboardType: keyboardType,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      )
                    : Text(
                        value,
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(14),
                          fontWeight: FontWeight.w700,
                          color: colors.textFieldTitle,
                          fontFamily: AppConstant.appHeaderFont,
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(width: 8.width),
          // Trailing icon
          Icon(trailingIcon, size: 22.width, color: colors.primaryBrand),
        ],
      ),
    );
  }
}
