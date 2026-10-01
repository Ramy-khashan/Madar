import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSubStageCubit extends Cubit<int> {
  CustomSubStageCubit() : controller = TextEditingController(), super(0);

  final TextEditingController controller;

  String takeName() {
    final name = controller.text.trim();
    if (name.isEmpty) return '';
    controller.clear();
    return name;
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
