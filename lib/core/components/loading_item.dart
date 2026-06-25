import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../config/theme/app_theme_colors.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: color ?? AppThemeColors.of(context).primaryBrand,
        size: 60,
      ),
    );
  }
}
