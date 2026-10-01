import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberFocusCubit extends Cubit<bool> {
  PhoneNumberFocusCubit() : super(false) {
    node.addListener(_onFocus);
  }

  final FocusNode node = FocusNode();

  void _onFocus() => emit(node.hasFocus);

  @override
  Future<void> close() {
    node.removeListener(_onFocus);
    node.dispose();
    return super.close();
  }
}
