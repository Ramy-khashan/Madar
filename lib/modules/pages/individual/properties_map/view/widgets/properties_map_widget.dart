import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/model/google_map_model.dart';

class PropertiesMapWidget extends StatefulWidget {
  const PropertiesMapWidget({
    super.key,
    required this.cameraTarget,
    required this.markers,
    required this.onTap,
    this.onCameraMove,
  });

  final PositionModel cameraTarget;
  final Set<Marker> markers;
  final void Function(LatLng) onTap;
  final void Function(LatLng)? onCameraMove;

  @override
  State<PropertiesMapWidget> createState() => _PropertiesMapWidgetState();
}

class _PropertiesMapWidgetState extends State<PropertiesMapWidget> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(PropertiesMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cameraTarget.position != oldWidget.cameraTarget.position) {
      _controller?.animateCamera(
        CameraUpdate.newLatLng(widget.cameraTarget.position),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: widget.cameraTarget.position,
        zoom: 14,
      ),
      markers: widget.markers,
      onMapCreated: (controller) {
        _controller = controller;
        controller.animateCamera(
          CameraUpdate.newLatLng(widget.cameraTarget.position),
        );
      },
      onTap: widget.onTap,
      onCameraMove: (position) =>
          widget.onCameraMove?.call(position.target),
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }
}
