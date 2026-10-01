import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/property_details/model/property_details_model.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'image_preview_screen.dart';
import 'video_slide.dart';
import 'gallery_page_cubit.dart';

class PropertyMediaGallery extends StatelessWidget {
  const PropertyMediaGallery({
    super.key,
    required this.media,
    required this.height,
    this.topStart,
    this.topEnd,
    this.pageController,
    this.onPageChanged,
  });

  final List<PropertyMedia>? media;
  final double height;
  final Widget? topStart;
  final Widget? topEnd;
  final PageController? pageController;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GalleryPageCubit(pageController),
      child: BlocBuilder<GalleryPageCubit, int>(
        builder: (context, currentPage) {
          final colors = AppThemeColors.of(context);
          final items = (media ?? []).playable;
          final controller = context.read<GalleryPageCubit>().controller;

          return ClipRRect(
            borderRadius: BorderRadius.circular(24.radius),
            child: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: double.infinity,
                  child: items.isEmpty
                      ? ImageItem(
                          '',
                          fit: BoxFit.cover,
                          height: height,
                          width: double.infinity,
                        )
                      : PageView.builder(
                          controller: controller,
                          itemCount: items.length,
                          onPageChanged: (index) {
                            context.read<GalleryPageCubit>().onPageChanged(
                              index,
                            );
                            onPageChanged?.call(index);
                          },
                          itemBuilder: (context, index) {
                            final item = items[index];
                            if (item.isVideo) {
                              return VideoSlide(
                                media: item,
                                height: height,
                                isActive: index == currentPage,
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                final images = items
                                    .where((m) => m.isImage)
                                    .map((m) => m.url ?? '')
                                    .where((url) => url.isNotEmpty)
                                    .toList();
                                ImagePreviewScreen.open(
                                  context,
                                  imageUrl: item.url ?? '',
                                  images: images,
                                );
                              },
                              child: ImageItem(
                                item.url ?? '',
                                fit: BoxFit.cover,
                                height: height,
                                width: double.infinity,
                              ),
                            );
                          },
                        ),
                ),
                if (items.length > 1)
                  Positioned(
                    bottom: 10.height,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        items.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 3.width),
                          width: currentPage == index ? 16.width : 6.width,
                          height: 6.height,
                          decoration: BoxDecoration(
                            color: currentPage == index
                                ? colors.primaryBrand
                                : colors.cardBackground.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(3.radius),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (topEnd != null)
                  Positioned(top: 12.height, right: 12.width, child: topEnd!),
                if (topStart != null)
                  Positioned(top: 12.height, left: 12.width, child: topStart!),
              ],
            ),
          );
        },
      ),
    );
  }
}
