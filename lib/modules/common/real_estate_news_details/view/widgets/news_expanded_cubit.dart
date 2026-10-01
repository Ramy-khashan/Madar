import 'package:flutter_bloc/flutter_bloc.dart';

class NewsExpandedCubit extends Cubit<bool> {
  NewsExpandedCubit() : super(false);

  void toggle() => emit(!state);
}
