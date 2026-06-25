import 'package:flutter/material.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_constant.dart';
import '../utils/functions/responsive.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    required this.label,
    required this.value,
    required this.colors,
    this.isSpaceBetween = false,
    super.key,
  });

  final String label;
  final String value;
  final bool isSpaceBetween;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
     if (label.isEmpty) {

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.height),
        child: Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            color: colors.textFieldTitle,
            fontFamily: AppConstant.appFont,
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.height),
      child: Row(
        children: [
          Expanded(
            flex: isSpaceBetween ? 1 : 0,
            child: Text(
              '$label: ',
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                color: colors.textFieldTitle,
                fontFamily: AppConstant.appFont,
              ),
            ),
          ),

          Text(
            value,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              color: colors.textFieldTitle,
              fontFamily: AppConstant.appFont,
            ),
          ),
        ],
      ),
    );
  }
}
