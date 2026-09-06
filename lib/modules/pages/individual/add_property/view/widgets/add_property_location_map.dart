import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    final tc = AppThemeColors.of(context);
    return ClipRRect(
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
    );
  }
}
