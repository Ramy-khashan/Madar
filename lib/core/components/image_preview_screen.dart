import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/app_theme_colors.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'image_preview_cubit.dart';

class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  final List<String> images;
  final int initialIndex;

  static List<String> previewable(Iterable<String> urls) {
    return urls.map((url) => url.trim()).where((url) {
      if (url.isEmpty) return false;
      final lower = url.toLowerCase();
      if (lower.contains('assets/')) return false;
      if (lower.contains('.pdf') ||
          lower.contains('.doc') ||
          lower.contains('.xls')) {
        return false;
      }
      return true;
    }).toList();
  }

  static Future<void> open(
    BuildContext context, {
    required String imageUrl,
    List<String>? images,
    int initialIndex = 0,
  }) {
    final urls = previewable(images ?? [imageUrl]);
    if (urls.isEmpty) return Future.value();
    final start = urls.contains(imageUrl)
        ? urls.indexOf(imageUrl)
        : initialIndex.clamp(0, urls.length - 1);
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ImagePreviewScreen(images: urls, initialIndex: start),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ImagePreviewCubit(initialIndex: initialIndex, count: images.length),
      child: BlocBuilder<ImagePreviewCubit, int>(
        builder: (context, index) {
          final colors = AppThemeColors.of(context);
          final pageController = context
              .read<ImagePreviewCubit>()
              .pageController;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: images.length > 1
                  ? Text(
                      '${index + 1} / ${images.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.responsiveFontScale(14),
                      ),
                    )
                  : null,
              centerTitle: true,
            ),
            body: PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: context.read<ImagePreviewCubit>().onPageChanged,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 5,
                  child: Center(
                    child: ImageItem(
                      images[index],
                      fit: BoxFit.contain,
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: images.length > 1
                ? SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.height),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          images.length,
                          (i) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.width),
                            width: i == index ? 16.width : 6.width,
                            height: 6.height,
                            decoration: BoxDecoration(
                              color: i == index
                                  ? colors.primaryBrand
                                  : Colors.white.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(3.radius),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}
