import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../core/model/google_map_model.dart';
import '../../../../../../core/repository/maps/map_style.dart';
import 'properties_map_cubit.dart';

class PropertiesMapWidget extends StatelessWidget {
  const PropertiesMapWidget({
    super.key,
    required this.cameraTarget,
    required this.markers,
    required this.onTap,
    this.onCameraMove,
    this.onCameraIdle,
    this.myLocationEnabled = false,
  });

  final PositionModel cameraTarget;
  final Set<Marker> markers;
  final void Function(LatLng) onTap;
  final void Function(LatLng)? onCameraMove;
  final VoidCallback? onCameraIdle;
  final bool myLocationEnabled;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PropertiesMapCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<PropertiesMapCubit>();
          cubit.follow(cameraTarget.position);
          return GoogleMap(
            style: cleanMapStyle,
            initialCameraPosition: CameraPosition(
              target: cameraTarget.position,
              zoom: 14,
            ),
            markers: markers,
            onMapCreated: (controller) {
              cubit.attach(controller, cameraTarget.position);
              controller.animateCamera(
                CameraUpdate.newLatLng(cameraTarget.position),
              );
            },
            onTap: onTap,
            onCameraMove: (position) => onCameraMove?.call(position.target),
            onCameraIdle: onCameraIdle,
            myLocationEnabled: myLocationEnabled,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          );
        },
      ),
    );
  }
}
