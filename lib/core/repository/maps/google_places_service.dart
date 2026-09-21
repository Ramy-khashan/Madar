import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';

import '../../model/google_place_model.dart';
import '../../utils/functions/print_state.dart';

class GooglePlacesService {
  GooglePlacesService({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              responseType: ResponseType.json,
              validateStatus: (status) => status != null && status < 500,
            ),
          );

  static const googleMapsApiKey = String.fromEnvironment('MAPS_API_KEY');
  static const _autocompleteUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  static const _detailsUrl =
      'https://maps.googleapis.com/maps/api/place/details/json';

  final Dio _dio;

  String? get _mapsApiKey {
    final key = googleMapsApiKey.trim();
    if (key.isEmpty || key == r'$(MAPS_API_KEY)') return null;
    return key;
  }

  Future<List<PlacePrediction>> searchPlaces(String query) async {
    final input = _normalizeQuery(query);
    if (input.isEmpty) return [];
    final key = _mapsApiKey;
    if (key == null) return [];

    try {
      final response = await _dio.get(
        _autocompleteUrl,
        queryParameters: {
          'input': input,
          'key': key,
          'language': 'ar',
          'components': 'country:eg|country:sa',
        },
      );
      final data = _asMap(response.data);
      final status = data['status']?.toString();
      if (status != null && status != 'OK' && status != 'ZERO_RESULTS') {
        printState('Places autocomplete status: $status ${data['error_message']}');
      }
      final predictions = data['predictions'];
      if (predictions is! List) return [];
      return predictions
          .whereType<Map>()
          .map((e) => PlacePrediction.fromJson(Map<String, dynamic>.from(e)))
          .where((e) => e.placeId.isNotEmpty)
          .toList();
    } catch (e) {
      printState('Places search failed: $e');
      return [];
    }
  }

  Future<PlaceDetails?> getPlaceLocation(String placeId) async {
    if (placeId.isEmpty) return null;
    final key = _mapsApiKey;
    if (key == null) return null;

    try {
      final response = await _dio.get(
        _detailsUrl,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry,name,formatted_address',
          'key': key,
          'language': 'ar',
        },
      );
      final result = _asMap(_asMap(response.data)['result']);
      final location = _asMap(_asMap(result['geometry'])['location']);
      final lat = (location['lat'] as num?)?.toDouble();
      final lng = (location['lng'] as num?)?.toDouble();
      if (lat == null || lng == null) return null;
      return PlaceDetails(
        placeId: placeId,
        name: result['name']?.toString() ?? '',
        formattedAddress: result['formatted_address']?.toString() ?? '',
        latitude: lat,
        longitude: lng,
      );
    } catch (e) {
      printState('Place details failed: $e');
      return null;
    }
  }

  Future<PlaceDetails?> geocodeQuery(String query) async {
    final input = _normalizeQuery(query);
    if (input.isEmpty) return null;
    try {
      await setLocaleIdentifier('ar');
      final locations = await locationFromAddress(input);
      if (locations.isEmpty) return null;
      final loc = locations.first;
      var address = input;
      try {
        final marks = await placemarkFromCoordinates(
          loc.latitude,
          loc.longitude,
        );
        if (marks.isNotEmpty) {
          final mark = marks.first;
          final line = [
            mark.name,
            mark.subLocality,
            mark.locality,
            mark.subAdministrativeArea,
            mark.administrativeArea,
            mark.country,
          ].where((e) => e != null && e.trim().isNotEmpty).join('، ');
          if (line.isNotEmpty) address = line;
        }
      } catch (_) {}
      return PlaceDetails(
        placeId: 'geocode',
        name: input,
        formattedAddress: address,
        latitude: loc.latitude,
        longitude: loc.longitude,
      );
    } catch (e) {
      printState('Geocode failed: $e');
      return null;
    }
  }

  String _normalizeQuery(String query) {
    const eastern = '٠١٢٣٤٥٦٧٨٩';
    var input = query.trim();
    for (var i = 0; i < eastern.length; i++) {
      input = input.replaceAll(eastern[i], '$i');
    }
    return input;
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    if (value is String && value.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map<String, dynamic>) return decoded;
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {}
    }
    return {};
  }
}
