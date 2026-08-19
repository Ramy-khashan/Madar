import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../config/theme/app_theme_colors.dart';
import '../../../../../core/components/app_appbar.dart';
import '../../../../../core/components/search_item.dart';
import '../../../../../core/model/google_map_model.dart';
import '../../../../../core/utils/constants/app_enums.dart';
import '../../../../../core/utils/constants/app_strings.dart';
import '../controller/properties_map_bloc.dart';
import 'widgets/maker_property_item.dart';
import 'widgets/nearest_property_toggle.dart';

class PropertiesMapScreen extends StatelessWidget {
  final PositionModel? initialPosition;
  const PropertiesMapScreen({super.key, this.initialPosition});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PropertiesMapBloc(initialPosition: initialPosition),
      child: const _PropertiesMapView(),
    );
  }
}

class _PropertiesMapView extends StatelessWidget {
  const _PropertiesMapView();

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);

    return Scaffold(
      appBar: AppAppbar(title: AppStrings.propertiesMapTitle),
      body: FutureBuilder(
        future: PropertiesMapBloc.buildMarkerIcons(colors.primaryBrand),
        builder: (context, snapshot) {
          final icons = snapshot.data;

          return BlocBuilder<PropertiesMapBloc, PropertiesMapState>(
            builder: (context, state) {
              final bloc = PropertiesMapBloc.get(context);
              final selectedIndex = state.selectedIndex >= 0
                  ? state.selectedIndex
                  : null;

              final propertyMarkers = bloc.propertyMarkers;

              final cameraTarget = selectedIndex != null
                  ? propertyMarkers[selectedIndex]
                  : bloc.targetPosition;

              final markers = propertyMarkers.asMap().entries.map((e) {
                BitmapDescriptor? icon;
                if (icons != null) {
                  icon = e.key == selectedIndex ? icons.selected : icons.normal;
                }
                return Marker(
                  markerId: MarkerId('property_${e.key}'),
                  position: e.value.position,
                  icon: icon ?? BitmapDescriptor.defaultMarker,
                  anchor: const Offset(0.5, 1.0),
                  onTap: () => bloc.add(SelectMarkerEvent(e.key)),
                );
              }).toSet();

              return Stack(
                children: [
                  Column(
                    children: [
                      SearchItem(
                        onFilterTap: () async {},
                        showMapButton: false,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            _MapWidget(
                              cameraTarget: cameraTarget,
                              markers: markers,
                              onTap: (_) {
                                if (selectedIndex != null) {
                                  bloc.add(const CloseMarkerEvent());
                                }
                              },
                            ),
                            if (state.status == RequestStatus.loading)
                              const Positioned.fill(
                                child: IgnorePointer(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            PositionedDirectional(
                              top: 8,
                              start: 3,
                              child: NearestPropertyToggle(
                                value: state.isNearestToMe,
                                onChanged: (bool value) =>
                                    bloc.add(ToggleNearestToMeEvent(value)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (selectedIndex != null)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: MarkerInfoCard(
                        colors: colors,
                        marker: propertyMarkers[selectedIndex],
                        property: state.selectedProperty,
                        onClose: () => bloc.add(const CloseMarkerEvent()),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// Owns the GoogleMapController — animates camera whenever [cameraTarget] changes.
class _MapWidget extends StatefulWidget {
  const _MapWidget({
    required this.cameraTarget,
    required this.markers,
    required this.onTap,
  });

  final PositionModel cameraTarget;
  final Set<Marker> markers;
  final void Function(LatLng) onTap;

  @override
  State<_MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<_MapWidget> {
  GoogleMapController? _controller;

  @override
  void didUpdateWidget(_MapWidget oldWidget) {
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
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }
}
