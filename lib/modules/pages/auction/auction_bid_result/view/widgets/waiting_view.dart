import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../model/auction_bid_result_model.dart';
import 'bid_info_row.dart';
import 'circle_progress_painter.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key, required this.result});
  final AuctionBidResultModel result;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    const maxSeconds = 5;
    final progress = result.countdownSeconds / maxSeconds;
    final label = result.countdownSeconds.toString().padLeft(2, '0');

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 24.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 32.height),
          Center(
            child: SizedBox(
              width: 160.width,
              height: 160.width,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    size: Size(160.width, 160.width),
                    painter: CircleProgressPainter(
                      progress: progress,
                      color: colors.primaryBrand,
                      bgColor: colors.textFieldBorder,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '00:$label',
                        style: TextStyle(
                          fontSize: context.responsiveFontScale(28),
                          fontWeight: FontWeight.w700,
                          fontFamily: AppConstant.appHeaderFont,
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.height),
          Text(
            AppStrings.bidWaitingTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(18),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.height),
          Text(
            AppStrings.bidWaitingNote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appFont,
              color: colors.textSecondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24.height),
          BidInfoRow(
            label: AppStrings.yourBidLabel,
            value:
                '${result.bidAmount.toStringAsFixed(0)} ${AppStrings.currency}',
          ),
          SizedBox(height: 8.height),
          BidInfoRow(
            label: AppStrings.propertyInfoSection,
            value: result.propertyTitle,
          ),
        ],
      ),
    );
  }
}
