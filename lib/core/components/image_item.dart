import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants/app_images.dart';
import 'loading_item.dart';

class ImageItem extends StatelessWidget {
  const ImageItem(
    this.img, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.borderRadius,
  });

  final String img;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BorderRadius? borderRadius;

  int? _decodePx(double? logical, double pixelRatio) {
    if (logical == null || !logical.isFinite || logical <= 0) return null;
    return (logical * pixelRatio).round().clamp(1, 1600);
  }

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final memCacheWidth = _decodePx(width, pixelRatio);
    final memCacheHeight = memCacheWidth == null
        ? _decodePx(height, pixelRatio)
        : null;
    Widget imageWidget;

    if (img.isNotEmpty && img.contains('assets/')) {
      imageWidget = img.contains('.svg')
          ? SvgPicture.asset(
              img,
              width: width,
              height: height,
              fit: fit ?? BoxFit.contain,
              colorFilter: color != null
                  ? ColorFilter.mode(color!, BlendMode.srcIn)
                  : null,
            )
          : Image.asset(
              img,
              width: width,
              height: height,
              cacheHeight: memCacheHeight,
              cacheWidth: memCacheWidth,
              fit: fit,
              color: color,
            );
    } else if (img.isNotEmpty) {
      imageWidget = CachedNetworkImage(
        imageUrl: img,
        height: height,
        width: width,
        fit: fit,
        color: color,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        errorListener: (_) {},
        placeholder: (context, url) =>
            SizedBox(width: width, height: height, child: const LoadingItem()),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.logoImagePlaceHolder,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
        ),
      );
    } else {
      imageWidget = Image.asset(
        AppImages.logoImagePlaceHolder,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }
}
