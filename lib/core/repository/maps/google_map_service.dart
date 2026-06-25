import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:geolocator/geolocator.dart';
 import '../../model/google_map_model.dart';
import 'map_service.dart';

class GoogleMapService implements MapService {
  gmap.GoogleMapController? _controller;
  static const gmap.CameraPosition _defaultCameraPosition = gmap.CameraPosition(
    target: gmap.LatLng(30.0444, 31.2357),
    zoom: 15,
  );

  @override
  Widget buildMap({
    required ValueChanged<PositionModel> onTap,
    Set<MarkerModel> markers = const {},
    PositionModel? initialPosition,
    VoidCallback? onMapReady,
  }) {
    return gmap.GoogleMap(
      mapType: gmap.MapType.normal,
      initialCameraPosition: initialPosition != null
          ? gmap.CameraPosition(target: initialPosition.position, zoom: 15)
          : _defaultCameraPosition,
      onMapCreated: (controller) {
        _controller = controller;
        onMapReady?.call();
      },
      onTap: (position) => onTap(
        PositionModel(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      ),
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: markers.map((marker) => marker.marker).toSet(),
    );
  }

  @override
  void moveTo(PositionModel position) {
    final controller = _controller;
    if (controller == null) return;
    controller.animateCamera(gmap.CameraUpdate.newLatLng(position.position));
  }

  @override
  Future<PositionModel?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    final position = await Geolocator.getCurrentPosition();
    return PositionModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  void zoomIn() {
    final controller = _controller;
    if (controller == null) return;
    controller.animateCamera(gmap.CameraUpdate.zoomIn());
  }

  @override
  void zoomOut() {
    final controller = _controller;
    if (controller == null) return;
    controller.animateCamera(gmap.CameraUpdate.zoomOut());
  }
}
