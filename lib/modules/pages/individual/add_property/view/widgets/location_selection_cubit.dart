import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/model/google_map_model.dart';

class LocationSelectionCubit extends Cubit<PositionModel?> {
  LocationSelectionCubit(super.initial);

  void select(PositionModel position) {
    final current = state;
    if (current?.position.latitude == position.position.latitude &&
        current?.position.longitude == position.position.longitude) {
      return;
    }
    emit(position);
  }
}
