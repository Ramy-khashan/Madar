import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/theme/app_theme_colors.dart';
import '../../../../../../core/model/google_map_model.dart';
import '../../../../../../core/repository/maps/map_service.dart';
import '../../../../../../core/utils/functions/service_locator.dart';
import '../../controller/add_property_bloc.dart';
import 'location_selection_cubit.dart';

class AddPropertyLocationMap extends StatelessWidget {
  const AddPropertyLocationMap({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AddPropertyBloc.get(context).state.model;
    final initial = model.latitude != null && model.longitude != null
        ? PositionModel(latitude: model.latitude!, longitude: model.longitude!)
        : null;
    final tc = AppThemeColors.of(context);
    return BlocProvider(
      create: (_) => LocationSelectionCubit(initial),
      child: BlocListener<AddPropertyBloc, AddPropertyState>(
        listenWhen: (prev, curr) =>
            prev.model.latitude != curr.model.latitude ||
            prev.model.longitude != curr.model.longitude,
        listener: (context, state) {
          final lat = state.model.latitude;
          final lng = state.model.longitude;
          if (lat == null || lng == null) return;
          final pos = PositionModel(latitude: lat, longitude: lng);
          context.read<LocationSelectionCubit>().select(pos);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            sl.get<MapService>().moveTo(pos);
          });
        },
        child: BlocBuilder<LocationSelectionCubit, PositionModel?>(
          builder: (context, selected) {
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
                    initialPosition: selected,
                    onTap: (pos) {
                      context.read<LocationSelectionCubit>().select(pos);
                      AddPropertyBloc.get(context).add(
                        MapLocationSelectedEvent(
                          latitude: pos.position.latitude,
                          longitude: pos.position.longitude,
                        ),
                      );
                    },
                    markers: selected == null
                        ? const {}
                        : {
                            MarkerModel(
                              markerId: 'property_location',
                              position: selected,
                            ),
                          },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
