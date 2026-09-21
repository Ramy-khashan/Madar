import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/model/google_map_model.dart';
import '../../../../../../core/repository/maps/map_service.dart';
import '../../../../../../core/utils/functions/service_locator.dart';
import '../../controller/add_property_bloc.dart';

class AddPropertyLocationMap extends StatefulWidget {
  const AddPropertyLocationMap({super.key});

  @override
  State<AddPropertyLocationMap> createState() => _AddPropertyLocationMapState();
}

class _AddPropertyLocationMapState extends State<AddPropertyLocationMap> {
  PositionModel? _selected;

  @override
  void initState() {
    super.initState();
    final model = AddPropertyBloc.get(context).state.model;
    if (model.latitude != null && model.longitude != null) {
      _selected = PositionModel(
        latitude: model.latitude!,
        longitude: model.longitude!,
      );
    }
  }

  void _syncSelection(double latitude, double longitude) {
    final pos = PositionModel(latitude: latitude, longitude: longitude);
    if (_selected?.position.latitude == latitude &&
        _selected?.position.longitude == longitude) {
      return;
    }
    setState(() => _selected = pos);
  }

  @override
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return BlocListener<AddPropertyBloc, AddPropertyState>(
      listenWhen: (prev, curr) =>
          prev.model.latitude != curr.model.latitude ||
          prev.model.longitude != curr.model.longitude,
      listener: (context, state) {
        final lat = state.model.latitude;
        final lng = state.model.longitude;
        if (lat == null || lng == null) return;
        _syncSelection(lat, lng);
        final pos = PositionModel(latitude: lat, longitude: lng);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          sl.get<MapService>().moveTo(pos);
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            border: Border.all(color: tc.borderColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: sl.get<MapService>().buildMap(
              initialPosition: _selected,
              onTap: (pos) {
                setState(() => _selected = pos);
                AddPropertyBloc.get(context).add(
                  MapLocationSelectedEvent(
                    latitude: pos.position.latitude,
                    longitude: pos.position.longitude,
                  ),
                );
              },
              markers: _selected == null
                  ? const {}
                  : {
                      MarkerModel(
                        markerId: 'property_location',
                        position: _selected!,
                      ),
                    },
            ),
          ),
        ),
      ),
    );
  }
}
