import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/auction_details_model.dart';
import 'colon.dart';
import 'time_box.dart';

class AcutionTimerPart extends StatelessWidget {
  const AcutionTimerPart({super.key, this.auction});
  final AuctionDetailsModel? auction;

  @override
  Widget build(BuildContext context) {
    final remaining = auction == null
        ? Duration.zero
        : auction!.endTime.difference(DateTime.now());
    final r = remaining.isNegative ? Duration.zero : remaining;
    final colors = AppThemeColors.of(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.textFieldFill,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6.radius),
          bottomRight: Radius.circular(6.radius),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 10.height,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 24.width,
                color: colors.primaryBrand,
              ),
              SizedBox(width: 6.width),

              Text(
                AppStrings.endsInLabel,
                style: TextStyle(
                  fontSize: context.responsiveFontScale(16),
                  fontFamily: AppConstant.appHeaderFont,
                  fontWeight: FontWeight.w600,
                  color: colors.textFieldTitle,
                ),
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(
              color: colors.primaryBrand.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.radius),
            ),
            child: Row(
              children: [
                TimeBox(value: r.inDays, label: AppStrings.daysLabel),
                const Colon(),
                TimeBox(value: r.inHours % 24, label: AppStrings.hoursLabel),
                const Colon(),
                TimeBox(
                  value: r.inMinutes % 60,
                  label: AppStrings.minutesLabel,
                ),
                const Colon(),
                TimeBox(
                  value: r.inSeconds % 60,
                  label: AppStrings.secondsLabel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
