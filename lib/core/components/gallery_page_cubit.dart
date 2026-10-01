import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryPageCubit extends Cubit<int> {
  GalleryPageCubit(PageController? external)
    : controller = external ?? PageController(),
      ownsController = external == null,
      super(0);

  final PageController controller;
  final bool ownsController;

  void onPageChanged(int index) => emit(index);

  @override
  Future<void> close() {
    if (ownsController) controller.dispose();
    return super.close();
  }
}
