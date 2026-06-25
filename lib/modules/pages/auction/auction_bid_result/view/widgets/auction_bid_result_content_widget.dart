import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/router/app_router_keys.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_button.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../../../../../core/utils/functions/router_handler.dart';
import '../../controller/auction_bid_result_bloc.dart';
import '../../model/auction_bid_result_model.dart';

class AuctionBidResultContentWidget extends StatelessWidget {
  const AuctionBidResultContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuctionBidResultBloc, AuctionBidResultState>(
      builder: (context, state) {
        final result = state.result;
        if (result == null) return const SizedBox();
        return switch (result.status) {
          BidResultStatus.waiting =>
            _WaitingView(result: result),
          BidResultStatus.won => _WonView(result: result),
          BidResultStatus.outbid => _OutbidView(result: result),
        };
      },
    );
  }
}

// ──────────────────────────────────────────────────
// Waiting – animated countdown
// ──────────────────────────────────────────────────
class _WaitingView extends StatelessWidget {
  const _WaitingView({required this.result});
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
                    painter: _CircleProgressPainter(
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
          _BidInfoRow(
            label: AppStrings.yourBidLabel,
            value:
                '${result.bidAmount.toStringAsFixed(0)} ${AppStrings.currency}',
          ),
          SizedBox(height: 8.height),
          _BidInfoRow(
            label: AppStrings.propertyInfoSection,
            value: result.propertyTitle,
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────
// Won
// ──────────────────────────────────────────────────
class _WonView extends StatelessWidget {
  const _WonView({required this.result});
  final AuctionBidResultModel result;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 24.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Container(
            width: 80.width,
            height: 80.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withValues(alpha:0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              size: 50.width,
              color: const Color(0xFF22C55E),
            ),
          ),
          SizedBox(height: 20.height),
          Text(
            AppStrings.bidWonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(22),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.height),
          Text(
            AppStrings.bidWonNote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(14),
              fontFamily: AppConstant.appFont,
              color: colors.textSecondary,
              height: 1.6,
            ),
          ),
          SizedBox(height: 24.height),
          _BidInfoRow(
            label: AppStrings.yourBidLabel,
            value:
                '${result.bidAmount.toStringAsFixed(0)} ${AppStrings.currency}',
          ),
          SizedBox(height: 8.height),
          _BidInfoRow(
            label: AppStrings.propertyInfoSection,
            value: result.propertyTitle,
          ),
          const Spacer(),
          AppButton(
            onTap: () => RouterHandler.navigate(context, AppRouterKeys.navbar, routerType: RouterType.goName),
            text: AppStrings.goHome,
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────
// Outbid
// ──────────────────────────────────────────────────
class _OutbidView extends StatelessWidget {
  const _OutbidView({required this.result});
  final AuctionBidResultModel result;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Container(
      color: const Color(0xFFFFF0F0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveHorizontalPadding,
          vertical: 24.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Container(
              width: 80.width,
              height: 80.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha:0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cancel_outlined,
                size: 50.width,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20.height),
            Text(
              AppStrings.bidOutbidTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(22),
                fontWeight: FontWeight.w700,
                fontFamily: AppConstant.appHeaderFont,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.height),
            Text(
              AppStrings.bidOutbidNote,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.responsiveFontScale(14),
                fontFamily: AppConstant.appFont,
                color: colors.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.height),
            _BidInfoRow(
              label: AppStrings.yourBidLabel,
              value:
                  '${result.bidAmount.toStringAsFixed(0)} ${AppStrings.currency}',
            ),
            const Spacer(),
            AppButton(
              onTap: () => RouterHandler.pop(context),
              text: AppStrings.placeBidBtn,
            ),
            SizedBox(height: 10.height),
            AppButton(
              onTap: () =>RouterHandler.navigate(context,AppRouterKeys.navbar,routerType: RouterType.goName),
              text: AppStrings.goHome,
              isOutline: true,
            ),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────
// Shared info row
// ──────────────────────────────────────────────────
class _BidInfoRow extends StatelessWidget {
  const _BidInfoRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.responsiveFontScale(13),
            fontFamily: AppConstant.appFont,
            color: colors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: context.responsiveFontScale(14),
            fontWeight: FontWeight.w600,
            fontFamily: AppConstant.appHeaderFont,
            color: colors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────
// Circular progress painter
// ──────────────────────────────────────────────────
class _CircleProgressPainter extends CustomPainter {
  const _CircleProgressPainter({
    required this.progress,
    required this.color,
    required this.bgColor,
  });
  final double progress;
  final Color color;
  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;
    final fgPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_CircleProgressPainter old) =>
      old.progress != progress;
}
