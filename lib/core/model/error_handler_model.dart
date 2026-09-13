import '../utils/constants/app_strings.dart';

/// Parses Node.js / Express error response bodies.
///
/// Handles the common shapes emitted by Express and express-validator:
///   { "message": "..." }
///   { "error": "..." }
///   { "errors": [{ "msg": "..." }, ...] }           ← express-validator array
///   { "errors": { "field": "...", ... } }            ← object / map shape
class ErrorHandlerModel {
  final String? message;
  final String? error;
  final dynamic errors;

  const ErrorHandlerModel({this.message, this.error, this.errors});

  factory ErrorHandlerModel.fromJson(Map<String, dynamic> json) {
    return ErrorHandlerModel(
      message: json['message']?.toString(),
      error: json['error']?.toString(),
      errors: json['errors'],
    );
  }

  /// Returns the first meaningful error string from the response.
  String get firstErrorMessage {
    if (message != null && message!.trim().isNotEmpty) {
      return _localizeMsg(message!.trim());
    }
    if (error != null && error!.trim().isNotEmpty) {
      return _localizeMsg(error!.trim());
    }

    final fieldLines = formattedFieldErrors;
    if (fieldLines.isNotEmpty) return fieldLines.first;

    if (errors is List && (errors as List).isNotEmpty) {
      for (final item in errors as List) {
        if (item is String && item.trim().isNotEmpty) {
          return _localizeMsg(item.trim());
        }
      }
    }

    if (errors is Map) {
      for (final value in (errors as Map).values) {
        if (value is String && value.trim().isNotEmpty) {
          return _localizeMsg(value.trim());
        }
        if (value is List && value.isNotEmpty) {
          final first = value.first;
          if (first is String && first.trim().isNotEmpty) {
            return _localizeMsg(first.trim());
          }
        }
      }
    }

    return 'An unexpected error occurred';
  }

  bool get hasFieldErrors => formattedFieldErrors.isNotEmpty;

  /// Field-level lines for add-property validation, e.g.
  /// `عدد الصالات: قيمة غير صحيحة`.
  String get createPropertyMessage {
    final lines = formattedFieldErrors;
    if (lines.isNotEmpty) return lines.join('\n');
    return firstErrorMessage;
  }

  List<String> get formattedFieldErrors {
    final lines = <String>[];
    if (errors is List) {
      for (final item in errors as List) {
        if (item is! Map) continue;
        final map = Map<String, dynamic>.from(item);
        final msg = (map['msg'] ?? map['message'] ?? map['error'])
            ?.toString()
            .trim();
        if (msg == null || msg.isEmpty) continue;
        final path = (map['path'] ?? map['param'] ?? '').toString().trim();
        lines.add(_fieldLine(path, msg));
      }
      return lines;
    }
    if (errors is Map) {
      (errors as Map).forEach((key, value) {
        String? msg;
        if (value is List && value.isNotEmpty) {
          msg = value.first?.toString().trim();
        } else if (value != null) {
          msg = value.toString().trim();
        }
        if (msg == null || msg.isEmpty) return;
        lines.add(_fieldLine(key.toString(), msg));
      });
    }
    return lines;
  }

  static String _fieldLine(String path, String msg) {
    final label = _labelForPath(path);
    final text = _localizeMsg(msg);
    return label.isEmpty ? text : '$label: $text';
  }

  static String _localizeMsg(String msg) {
    final lower = msg.toLowerCase();
    if (lower.contains('invalid value') ||
        lower.contains('invalid type') ||
        lower == 'invalid') {
      return AppStrings.invalidFieldValue;
    }
    return msg;
  }

  static String _labelForPath(String path) {
    if (path.isEmpty) return '';
    final key = path.split('.').last;
    switch (key) {
      case 'councils':
        return AppStrings.numberOfLounges;
      case 'livingRooms':
        return AppStrings.numberOfLivingRooms;
      case 'totalFloors':
      case 'floorsCount':
        return AppStrings.totalFloorsInBuilding;
      case 'bedrooms':
        return AppStrings.numberOfBedrooms;
      case 'bathrooms':
        return AppStrings.numberOfBathrooms;
      case 'kitchens':
        return AppStrings.numberOfKitchensOptional;
      case 'floor':
        return AppStrings.floorLabelShort;
      case 'apartmentsPerFloor':
        return AppStrings.apartmentsPerFloorOptional;
      case 'apartmentNumber':
        return AppStrings.apartmentNumberOptional;
      case 'totalApartments':
        return AppStrings.totalApartments;
      case 'parkingSpots':
        return AppStrings.numberOfParkingSpaces;
      case 'shopsCount':
        return AppStrings.numberOfShopsOptional;
      case 'title':
        return AppStrings.propertyName;
      case 'price':
        return AppStrings.listingPrice;
      case 'totalArea':
        return AppStrings.areaSqmRequired;
      case 'type':
        return AppStrings.propertyType;
      default:
        return _humanizeKey(key);
    }
  }

  static String _humanizeKey(String key) {
    final spaced = key
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .replaceAll('_', ' ')
        .replaceAll('.', ' ')
        .trim();
    if (spaced.isEmpty) return key;
    return spaced[0].toUpperCase() + spaced.substring(1);
  }
}
