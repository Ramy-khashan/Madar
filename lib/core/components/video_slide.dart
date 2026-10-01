import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/property_details/model/property_details_model.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';
import 'video_slide_cubit.dart';

class VideoSlide extends StatelessWidget {
  const VideoSlide({
    super.key,
    required this.media,
    required this.height,
    required this.isActive,
  });

  final PropertyMedia media;
  final double height;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoSlideCubit(),
      child: BlocBuilder<VideoSlideCubit, VideoSlideViewState>(
        builder: (context, state) {
          final cubit = context.read<VideoSlideCubit>();
          cubit.pauseIfInactive(isActive);
          final colors = AppThemeColors.of(context);
          final controller = state.controller;
          final playing = state.playing;
          return GestureDetector(
            onTap: () => cubit.toggle(url: media.url, isActive: isActive),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (state.ready && controller != null)
                  ColoredBox(
                    color: Colors.black,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio == 0
                            ? 16 / 9
                            : controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      ),
                    ),
                  )
                else
                  ImageItem(
                    media.thumbnailUrl,
                    fit: BoxFit.cover,
                    height: height,
                    width: double.infinity,
                  ),
                if (!playing)
                  Center(
                    child: Container(
                      width: 56.width,
                      height: 56.width,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: colors.onPrimary,
                        size: 36.width,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 28.height,
                  right: 12.width,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.width,
                      vertical: 4.height,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20.radius),
                    ),
                    child: Text(
                      media.isVirtualTour
                          ? AppStrings.tour360
                          : AppStrings.videoLabel,
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: context.responsiveFontScale(11),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
