import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PropertiesMapCubit extends Cubit<int> {
  PropertiesMapCubit() : super(0);

  GoogleMapController? controller;
  LatLng? lastTarget;

  void attach(GoogleMapController mapController, LatLng target) {
    controller = mapController;
    lastTarget = target;
  }

  void follow(LatLng target) {
    if (controller == null || lastTarget == target) return;
    lastTarget = target;
    controller!.animateCamera(CameraUpdate.newLatLng(target));
  }

  @override
  Future<void> close() {
    controller?.dispose();
    return super.close();
  }
}
