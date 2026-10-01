import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/utils/functions/responsive.dart';

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
          builder: (_, _) => Padding(
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
