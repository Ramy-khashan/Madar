import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/auction_details_model.dart';

class AcutionTimerPart extends StatefulWidget {
  const AcutionTimerPart({super.key, this.auction});
  final AuctionDetailsModel? auction;
  @override
  State<AcutionTimerPart> createState() => _AcutionTimerPartState();
}

class _AcutionTimerPartState extends State<AcutionTimerPart> {
  late final Duration remaining;
  late final Duration r;

  @override
  void initState() {
    super.initState();
    if (widget.auction != null) {
      remaining = widget.auction!.endTime.difference(DateTime.now());
      r = remaining.isNegative ? Duration.zero : remaining;
    } else {
      remaining = Duration.zero;
      r = Duration.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
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

class TimeBox extends StatelessWidget {
  const TimeBox({super.key, required this.value, required this.label});
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 8.width,
            vertical: 4.height,
          ),

          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: context.responsiveFontScale(12),
              fontFamily: AppConstant.appHeaderFont,
              fontWeight: FontWeight.w700,
              color: colors.primaryBrand,
            ),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(10),
            fontFamily: AppConstant.appFont,
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class Colon extends StatelessWidget {
  const Colon({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: 14.height,
        left: 3.width,
        right: 3.width,
      ),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: context.responsiveFontScale(14),
          fontWeight: FontWeight.w700,
          color: colors.primaryBrand,
        ),
      ),
    );
  }
}
