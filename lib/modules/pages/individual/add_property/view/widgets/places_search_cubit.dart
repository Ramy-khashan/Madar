import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesSearchCubit extends Cubit<int> {
  PlacesSearchCubit() : super(0);

  Timer? debounce;

  void schedule(void Function() action) {
    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 350), action);
  }

  void cancel() => debounce?.cancel();

  @override
  Future<void> close() {
    debounce?.cancel();
    return super.close();
  }
}
