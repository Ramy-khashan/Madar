import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertiesMapCubit extends Cubit<int> {
  PropertiesMapCubit() : super(0);

  GoogleMapController? controller;
  LatLng? lastTarget;
  bool _closed = false;

  void attach(GoogleMapController mapController, LatLng target) {
    controller = mapController;
    lastTarget = target;
  }

  void follow(LatLng target) {
    final map = controller;
    if (_closed || map == null || lastTarget == target) return;
    lastTarget = target;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_closed || controller != map) return;
      map.animateCamera(CameraUpdate.newLatLng(target));
    });
  }

  @override
  Future<void> close() {
    _closed = true;
    controller = null;
    return super.close();
  }
}
