import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTextFieldFocusCubit extends Cubit<bool> {
  AppTextFieldFocusCubit(FocusNode? external)
    : node = external ?? FocusNode(),
      ownsNode = external == null,
      super(external?.hasFocus ?? false) {
    node.addListener(_onFocus);
  }

  final FocusNode node;
  final bool ownsNode;

  void _onFocus() => emit(node.hasFocus);

  @override
  Future<void> close() {
    node.removeListener(_onFocus);
    if (ownsNode) node.dispose();
    return super.close();
  }
}
