import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandedStagesCubit extends Cubit<Set<String>> {
  ExpandedStagesCubit() : super(const {});

  void toggle(String stageId) {
    final next = {...state};
    if (next.contains(stageId)) {
      next.remove(stageId);
    } else {
      next.add(stageId);
    }
    emit(next);
  }
}
