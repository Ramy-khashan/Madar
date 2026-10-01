import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchQueryCubit extends Cubit<int> {
  SearchQueryCubit(String? initial)
    : controller = TextEditingController(text: initial),
      super(0);

  final TextEditingController controller;

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
