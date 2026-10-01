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
        initializing.addListener(() {
          if (!isClosed && state.controller != null) {
            emit(
              VideoSlideViewState(controller: state.controller, ready: true),
            );
          }
        });
        await initializing.setLooping(true);
        if (isActive) await initializing.play();
        emit(VideoSlideViewState(controller: initializing, ready: true));
        return;
      }
      if (state.controller!.value.isPlaying) {
        await state.controller!.pause();
      } else {
        await state.controller!.play();
      }
      if (!isClosed) {
        emit(VideoSlideViewState(controller: state.controller, ready: true));
      }
    } catch (_) {
      await initializing?.dispose();
      if (isClosed) return;
      await state.controller?.dispose();
      emit(const VideoSlideViewState());
    }
  }

  void pauseIfInactive(bool isActive) {
    if (!isActive) state.controller?.pause();
  }

  @override
  Future<void> close() async {
    await state.controller?.dispose();
    return super.close();
  }
}
