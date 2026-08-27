import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/components/app_appbar.dart';
import '../../../../../../core/components/search_item.dart';
import '../../../../../../core/utils/constants/app_enums.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../common/filter/view/filter_sheet_view.dart';
import '../../controller/properties_map_bloc.dart';
import 'maker_property_item.dart';
import 'nearest_property_toggle.dart';
import 'properties_map_widget.dart';

class PropertiesMapView extends StatelessWidget {
  const PropertiesMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppThemeColors.of(context);
    final bloc = PropertiesMapBloc.get(context);

    return Scaffold(
      appBar: AppAppbar(title: AppStrings.propertiesMapTitle),
      body: Column(
        children: [
          SearchItem(
            showMapButton: false,
            onSearchChanged: (value) => bloc.add(MapSearchChanged(value)),
            onFilterTap: () {
              showFilterSheet(
                context,
                initialFilter: bloc.state.filter,
                onApply: (result) => bloc.add(MapFilterApplied(result)),
              );
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: PropertiesMapBloc.buildMarkerIcons(colors.primaryBrand),
              builder: (context, snapshot) {
                final icons = snapshot.data;

                return BlocBuilder<PropertiesMapBloc, PropertiesMapState>(
                  builder: (context, state) {
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
                        icon = e.key == selectedIndex
                            ? icons.selected
                            : icons.normal;
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
                        PropertiesMapWidget(
                          cameraTarget: cameraTarget,
                          markers: markers,
                          onTap: (_) {
                            if (selectedIndex != null) {
                              bloc.add(const CloseMarkerEvent());
                            }
                          },
                          onCameraMove: (latLng) {
                            bloc.add(
                              MapCameraMoved(
                                latLng.latitude,
                                latLng.longitude,
                              ),
                            );
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
                        if (selectedIndex != null)
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: MarkerInfoCard(
                              colors: colors,
                              marker: propertyMarkers[selectedIndex],
                              property: state.selectedProperty,
                              onClose: () =>
                                  bloc.add(const CloseMarkerEvent()),
                            ),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
