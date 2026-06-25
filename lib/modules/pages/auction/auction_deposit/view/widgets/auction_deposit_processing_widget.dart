import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/constants/app_colors.dart';
import '../../../../../../core/utils/constants/app_constant.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';

class AuctionDepositProcessingWidget extends StatefulWidget {
  const AuctionDepositProcessingWidget({super.key});

  @override
  State<AuctionDepositProcessingWidget> createState() =>
      _AuctionDepositProcessingWidgetState();
}

class _AuctionDepositProcessingWidgetState
    extends State<AuctionDepositProcessingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _dotController;

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.responsiveHorizontalPadding,
        vertical: 24.height,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.width,
            height: 100.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primary300.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: SizedBox(
              width: 52.width,
              height: 52.width,
              child: CircularProgressIndicator(
                color: AppThemeColors.of(context).primaryBrand,
                strokeWidth: 3.5,
              ),
            ),
          ),
          SizedBox(height: 32.height),
          Text(
            AppStrings.depositProcessingTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(20),
              fontWeight: FontWeight.w700,
              fontFamily: AppConstant.appHeaderFont,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 10.height),
          Text(
            AppStrings.depositProcessingSub,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.responsiveFontScale(13),
              fontFamily: AppConstant.appFont,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.55),
              height: 1.6,
            ),
          ),
          SizedBox(height: 32.height),
          AnimatedDots(controller: _dotController),
        ],
      ),
    );
  }
}

class AnimatedDots extends StatelessWidget {
  const AnimatedDots({super.key, required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final start = i / 3;
        final end = (i + 1) / 3;
        final anim = Tween<double>(begin: 0.3, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(start, end, curve: Curves.easeInOut),
          ),
        );
        return AnimatedBuilder(
          animation: anim,
          builder: (_, __) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.width),
            child: Opacity(
              opacity: anim.value,
              child: Container(
                width: 10.width,
                height: 10.width,
                decoration: BoxDecoration(
                  color: AppThemeColors.of(context).primaryBrand,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
