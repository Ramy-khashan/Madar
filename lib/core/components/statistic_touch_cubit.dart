import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticTouchCubit extends Cubit<int> {
  StatisticTouchCubit() : super(-1);

  void select(int index) => emit(index);
}
