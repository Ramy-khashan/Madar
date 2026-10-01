import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/row_model.dart';

class ConfirmCard extends StatelessWidget {
  const ConfirmCard({
    required this.title,
    required this.rows,
    required this.colors,
    super.key,
  });

  final String title;
  final List<RowModel> rows;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.width),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(12.radius),
        border: Border.all(color: colors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textFieldTitle,
            ),
          ),
          SizedBox(height: 8.height),
          ...rows
              .where((r) => r.value.isNotEmpty || r.label.isNotEmpty)
              .map(
                (r) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.height),
                  child: r.value.isEmpty
                      ? Text(
                          r.label,
                          style: TextStyle(
                            fontSize: context.responsiveFontScale(13),
                            color: colors.textSecondary,
                            fontFamily: AppConstant.appFont,
                          ),
                        )
                      : Row(
                          children: [
                            Text(
                              '${r.label}: ',
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textFieldTitle,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                            Text(
                              r.value,
                              style: TextStyle(
                                fontSize: context.responsiveFontScale(13),
                                color: colors.textSecondary,
                                fontFamily: AppConstant.appFont,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
        ],
      ),
    );
  }
}
