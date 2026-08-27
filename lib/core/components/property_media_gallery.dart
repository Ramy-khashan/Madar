import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../config/theme/app_theme_colors.dart';
import '../../modules/pages/individual/property_details/model/property_details_model.dart';
import '../utils/constants/app_strings.dart';
import '../utils/functions/responsive.dart';
import 'image_item.dart';

class PropertyMediaGallery extends StatefulWidget {
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
  State<PropertyMediaGallery> createState() => _PropertyMediaGalleryState();
}

class _PropertyMediaGalleryState extends State<PropertyMediaGallery> {
  late final PageController _controller;
  late final bool _ownsController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.pageController == null;
    _controller = widget.pageController ?? PageController();
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final items = (widget.media ?? []).playable;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.radius),
      child: Stack(
        children: [
          SizedBox(
            height: widget.height,
            width: double.infinity,
            child: items.isEmpty
                ? ImageItem(
                    '',
                    fit: BoxFit.cover,
                    height: widget.height,
                    width: double.infinity,
                  )
                : PageView.builder(
                    controller: _controller,
                    itemCount: items.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      widget.onPageChanged?.call(index);
                    },
                    itemBuilder: (context, index) {
                      final item = items[index];
                      if (item.isVideo) {
                        return _VideoSlide(
                          media: item,
                          height: widget.height,
                          isActive: index == _currentPage,
                        );
                      }
                      return ImageItem(
                        item.url ?? '',
                        fit: BoxFit.cover,
                        height: widget.height,
                        width: double.infinity,
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
                    width: _currentPage == index ? 16.width : 6.width,
                    height: 6.height,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? colors.primaryBrand
                          : colors.cardBackground.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(3.radius),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.topEnd != null)
            Positioned(
              top: 12.height,
              right: 12.width,
              child: widget.topEnd!,
            ),
          if (widget.topStart != null)
            Positioned(
              top: 12.height,
              left: 12.width,
              child: widget.topStart!,
            ),
        ],
      ),
    );
  }
}

class _VideoSlide extends StatefulWidget {
  const _VideoSlide({
    required this.media,
    required this.height,
    required this.isActive,
  });

  final PropertyMedia media;
  final double height;
  final bool isActive;

  @override
  State<_VideoSlide> createState() => _VideoSlideState();
}

class _VideoSlideState extends State<_VideoSlide> {
  VideoPlayerController? _controller;
  bool _ready = false;

  @override
  void didUpdateWidget(covariant _VideoSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isActive) {
      _controller?.pause();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    final url = widget.media.url;
    if (url == null || url.isEmpty) return;
    VideoPlayerController? initializing;
    try {
      if (_controller == null) {
        initializing = VideoPlayerController.networkUrl(Uri.parse(url));
        await initializing.initialize();
        if (!mounted) {
          await initializing.dispose();
          return;
        }
        initializing.addListener(() {
          if (mounted) setState(() {});
        });
        await initializing.setLooping(true);
        if (widget.isActive) {
          await initializing.play();
        }
        setState(() {
          _controller = initializing;
          _ready = true;
        });
        return;
      }
      if (_controller!.value.isPlaying) {
        await _controller!.pause();
      } else {
        await _controller!.play();
      }
      if (mounted) setState(() {});
    } catch (_) {
      await initializing?.dispose();
      if (!mounted) return;
      await _controller?.dispose();
      setState(() {
        _controller = null;
        _ready = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final playing = _controller?.value.isPlaying ?? false;
    return GestureDetector(
      onTap: _toggle,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_ready && _controller != null)
            ColoredBox(
              color: Colors.black,
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio == 0
                      ? 16 / 9
                      : _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
            )
          else
            ImageItem(
              widget.media.thumbnailUrl,
              fit: BoxFit.cover,
              height: widget.height,
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
                widget.media.isVirtualTour
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
  }
}
