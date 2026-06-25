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

  @override
  Widget build(BuildContext context) {
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
              cacheHeight: (height != null && height!.isFinite)
                  ? height!.toInt()
                  : null,
              cacheWidth: (width != null && width!.isFinite)
                  ? width!.toInt()
                  : null,
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
        errorListener: (_) {},
        placeholder: (context, url) =>
            SizedBox(width: width, height: height, child: const LoadingItem()),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.logo,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
        ),
      );
    } else {
      imageWidget = Image.asset(
        AppImages.logo,
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
