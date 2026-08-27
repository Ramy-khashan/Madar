import 'package:dio/dio.dart';
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

  Future<
    ({
      String label,
      String city,
      String district,
      String houseNumber,
      String street,
    })?
  >
  _reverseGeocode(double lat, double lon) async {
    try {
      final response = await sl.get<Dio>().get<Map<String, dynamic>>(
        'https://nominatim.openstreetmap.org/reverse',
        queryParameters: {
          'format': 'json',
          'lat': lat,
          'lon': lon,
          'addressdetails': 1,
          'accept-language': 'ar',
        },
        options: Options(headers: {'User-Agent': 'MadarApp/1.0'}),
      );
      final addr = response.data?['address'] as Map<String, dynamic>?;
      if (addr == null) return null;

      final neighbourhood = (addr['neighbourhood'] ?? addr['suburb'] ?? '')
          .toString()
          .trim();
      final city = (addr['city'] ?? addr['town'] ?? addr['village'] ?? '')
          .toString()
          .trim();
      final road = (addr['road'] ?? addr['street'] ?? '').toString().trim();
      final house = (addr['house_number'] ?? '').toString().trim();

      final line1 = [neighbourhood, city].where((s) => s.isNotEmpty).join('، ');
      final line2 = [road, house].where((s) => s.isNotEmpty).join(' ');

      return (
        label: [line1, line2].where((s) => s.isNotEmpty).join('\n'),
        city: city,
        district: neighbourhood,
        houseNumber: house,
        street: road,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _onMapTap(PositionModel pos, BuildContext context) async {
    setState(() => _selected = pos);
    final bloc = AddPropertyBloc.get(context);
    // Show fallback coordinates immediately
    bloc.add(
      UpdateLocationEvent(
        '${pos.position.latitude.toStringAsFixed(5)}, ${pos.position.longitude.toStringAsFixed(5)}',
      ),
    );
    bloc.add(
      UpdateCoordinatesEvent(
        latitude: pos.position.latitude,
        longitude: pos.position.longitude,
      ),
    );
    // Replace with human-readable address once resolved
    final address = await _reverseGeocode(
      pos.position.latitude,
      pos.position.longitude,
    );
    if (address != null && mounted) {
      bloc.add(UpdateLocationEvent(address.label));
      bloc.add(
        UpdateCoordinatesEvent(
          latitude: pos.position.latitude,
          longitude: pos.position.longitude,
          city: address.city,
          district: address.district,
        ),
      );
      bloc.buildingNumberController.text = address.houseNumber;
      bloc.streetController.text = address.street;
    }
  }

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
            onTap: (pos) => _onMapTap(pos, context),
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
