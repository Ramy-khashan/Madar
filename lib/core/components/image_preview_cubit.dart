import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePreviewCubit extends Cubit<int> {
  ImagePreviewCubit({required int initialIndex, required int count})
    : pageController = PageController(
        initialPage: count == 0 ? 0 : initialIndex.clamp(0, count - 1),
      ),
      super(count == 0 ? 0 : initialIndex.clamp(0, count - 1));

  final PageController pageController;

  void onPageChanged(int index) => emit(index);

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
