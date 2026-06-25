import 'package:flutter/material.dart';

import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';

class SpinnerRowItem extends StatelessWidget {
  const SpinnerRowItem({super.key, 
    required this.label,
     required this.colors,
  });

  final String label;
   final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(colors.primaryBrand),
              strokeWidth: 2.5.width,
              value: null,
           ),
            SizedBox(width: 12.width),
        
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(14),
                  color: colors.textFieldTitle,
                  fontFamily: AppConstant.appFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
