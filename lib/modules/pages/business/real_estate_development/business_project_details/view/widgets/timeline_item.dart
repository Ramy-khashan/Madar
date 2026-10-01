import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../../core/utils/functions/time_ago.dart';
import '../../model/real_state_project_model.dart';

class TimelineItem extends StatelessWidget {
  const TimelineItem({
    super.key,
    required this.index,
    required this.item,
    required this.colors,
  });

  final int index;
  final Timeline item;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.height),
      padding: EdgeInsets.symmetric(horizontal: 12.width, vertical: 8.height),
      decoration: BoxDecoration(
        color: colors.borderColor.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(12.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12.width,
            backgroundColor: AppColors.primary300,

            child: Padding(
              padding: EdgeInsets.only(top: 2.height),
              child: Text(
                '$index',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(12),
                  fontWeight: FontWeight.w700,
                  color: colors.onPrimary,
                  fontFamily: AppConstant.appHeaderFont,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.width),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTimeHandler.convertDate(
                    item.date == null
                        ? DateTime.now()
                        : DateTime.parse(item.date!),
                  ),
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    fontWeight: FontWeight.w600,
                    fontFamily: AppConstant.appHeaderFont,
                    color: colors.primaryBrand,
                  ),
                ),
                SizedBox(height: 2.height),
                Text(
                  item.content ?? 'stage content',
                  style: TextStyle(
                    fontSize: context.responsiveFontScale(16),
                    color: colors.textSecondary,
                    fontFamily: AppConstant.appFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
