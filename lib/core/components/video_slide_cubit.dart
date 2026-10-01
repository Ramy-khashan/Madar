import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoSlideViewState {
  const VideoSlideViewState({this.controller, this.ready = false});

  final VideoPlayerController? controller;
  final bool ready;

  bool get playing => controller?.value.isPlaying ?? false;
}

class VideoSlideCubit extends Cubit<VideoSlideViewState> {
  VideoSlideCubit() : super(const VideoSlideViewState());

  bool? _appliedActive;
  bool? get appliedActive => _appliedActive;

  Future<void> toggle({required String? url, required bool isActive}) async {
    if (url == null || url.isEmpty) return;
    VideoPlayerController? initializing;
    try {
      if (state.controller == null) {
        initializing = VideoPlayerController.networkUrl(Uri.parse(url));
        await initializing.initialize();
        if (isClosed) {
          await initializing.dispose();
          return;
        }
        await initializing.setLooping(true);
        if (isActive) await initializing.play();
        emit(VideoSlideViewState(controller: initializing, ready: true));
        return;
      }
      final controller = state.controller!;
      if (controller.value.isPlaying) {
        await controller.pause();
      } else if (isActive) {
        await controller.play();
      }
      if (!isClosed) {
        emit(VideoSlideViewState(controller: controller, ready: true));
      }
    } catch (_) {
      await initializing?.dispose();
      if (isClosed) return;
      await state.controller?.dispose();
      emit(const VideoSlideViewState());
    }
  }

  void syncActive(bool isActive) {
    if (_appliedActive == isActive) return;
    _appliedActive = isActive;
    final controller = state.controller;
    if (isActive || controller == null || !controller.value.isPlaying) return;
    controller.pause();
    if (!isClosed) {
      emit(VideoSlideViewState(controller: controller, ready: state.ready));
    }
  }

  @override
  Future<void> close() async {
    await state.controller?.dispose();
    return super.close();
  }
}
