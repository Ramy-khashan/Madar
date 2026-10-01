import 'package:flutter/material.dart';
import '../../config/theme/app_theme_colors.dart';
import '../utils/constants/app_images.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.isBroker,
    this.imageUrl,
    required this.colors,
  });

  final bool isBroker;
  final String? imageUrl;
  final AppThemeColors colors;

  @override
  Widget build(BuildContext context) {
    final image = ImageItem(
      imageUrl ?? AppImages.agentImage,
      fit: BoxFit.cover,
      width: isBroker ? 48.width : 46.width,
      height: isBroker ? 48.width : 46.width,
    );

    if (isBroker) {
      return Container(
        width: 52.width,
        height: 52.width,
        decoration: BoxDecoration(
          color: colors.primaryBrand.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.radius),
        ),
        child: image,
      );
    }

    return Container(
      width: 52.width,
      height: 52.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primaryBrand.withValues(alpha: 0.1),
      ),
      child: ClipOval(child: image),
    );
  }
}
