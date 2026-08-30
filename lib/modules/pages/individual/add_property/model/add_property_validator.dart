import '../../../../../core/utils/constants/app_strings.dart';
import 'add_property_model.dart';
import 'add_property_request_mapper.dart';
import 'property_enums.dart';

/// Keys used both by the validator and by widgets that show `errorText`.
class AddPropertyField {
  AddPropertyField._();

  static const String propertyType = 'propertyType';
  static const String rentalPeriod = 'rentalPeriod';
  static const String location = 'location';
  static const String deedType = 'deedType';
  static const String deedNumber = 'deedNumber';
  static const String deedDate = 'deedDate';
  static const String customTypeName = 'customTypeName';
  static const String ownershipDocument = 'ownershipDocument';
  static const String images = 'images';
  static const String area = 'area';
  static const String facade = 'facade';
  static const String streetWidth = 'streetWidth';
  static const String propertyAge = 'propertyAge';
  static const String price = 'price';
  static const String title = 'title';
}

/// Step-gated validation for the add-property wizard.
///
/// Returns a map of field key → localized message. An empty map means the
/// current step (or the whole form) is ready to submit.
class AddPropertyValidator {
  AddPropertyValidator._();

  static Map<String, String> validateType(AddPropertyModel model) =>
      _type(model);

  static Map<String, String> validatePeriod(AddPropertyModel model) =>
      _period(model);

  static Map<String, String> validateLocation(AddPropertyModel model) =>
      _location(model);

  static Map<String, String> validateImages(AddPropertyModel model) =>
      _images(model);

  static Map<String, String> validateDetails(AddPropertyModel model) =>
      _details(model);

  static Map<String, String> validateReview(AddPropertyModel model) =>
      _review(model);

  static Map<String, String> _type(AddPropertyModel model) {
    if (model.propertyType == null || model.propertyType!.isEmpty) {
      return {
        AddPropertyField.propertyType: AppStrings.pleaseCompleteField(
          AppStrings.propertyTypeAndOperation,
        ),
      };
    }
    return const {};
  }

  static Map<String, String> _period(AddPropertyModel model) {
    if (model.rentalPeriod.isEmpty) {
      return {
        AddPropertyField.rentalPeriod: AppStrings.pleaseCompleteField(
          AppStrings.rentDuration,
        ),
      };
    }
    return const {};
  }

  static Map<String, String> _location(AddPropertyModel model) {
    final errors = <String, String>{};
    if (model.latitude == null || model.longitude == null) {
      errors[AddPropertyField.location] = AppStrings.pleaseSelectLocationOnMap;
    }
    if (model.deedType == null || model.deedType!.isEmpty) {
      errors[AddPropertyField.deedType] = AppStrings.pleaseCompleteField(
        AppStrings.deed,
      );
      return errors;
    }
    if (model.needsDeedNumberAndDate) {
      if (model.deedNumber.isEmpty) {
        errors[AddPropertyField.deedNumber] = AppStrings.pleaseCompleteField(
          AppStrings.deedNumber,
        );
      }
      if (model.date.isEmpty) {
        errors[AddPropertyField.deedDate] = AppStrings.pleaseCompleteField(
          AppStrings.deedDate,
        );
      }
    }
    if (model.needsCustomTypeName && model.customTypeName.trim().isEmpty) {
      errors[AddPropertyField.customTypeName] = AppStrings.pleaseCompleteField(
        AppStrings.customDeedTypeName,
      );
    }
    if (model.needsOwnershipDocument &&
        (model.ownershipDocumentPath == null ||
            model.ownershipDocumentPath!.isEmpty)) {
      errors[AddPropertyField.ownershipDocument] =
          AppStrings.pleaseCompleteField(AppStrings.ownershipDocument);
    }
    return errors;
  }

  static Map<String, String> _images(AddPropertyModel model) {
    if (model.imagePaths.isEmpty) {
      return {AddPropertyField.images: AppStrings.pleaseAddAtLeastOnePhoto};
    }
    return const {};
  }

  static Map<String, String> _details(AddPropertyModel model) {
    final errors = <String, String>{};
    if (!_hasPositiveNumber(model.area)) {
      errors[AddPropertyField.area] = AppStrings.pleaseCompleteField(
        AppStrings.areaSqmRequired,
      );
    }
    if (model.facade == null || model.facade!.isEmpty) {
      errors[AddPropertyField.facade] = AppStrings.pleaseCompleteField(
        AppStrings.facadeLabel,
      );
    }
    if (!_hasPositiveNumber(model.streetWidth)) {
      errors[AddPropertyField.streetWidth] = AppStrings.pleaseCompleteField(
        AppStrings.streetWidth,
      );
    }
    if (model.propertyAge == null || model.propertyAge!.isEmpty) {
      errors[AddPropertyField.propertyAge] = AppStrings.pleaseCompleteField(
        AppStrings.propertyAgeLabel,
      );
    }
    errors.addAll(_typeDetails(model));
    return errors;
  }

  static Map<String, String> _review(AddPropertyModel model) {
    final errors = <String, String>{};
    if (!_hasPositiveNumber(model.price)) {
      errors[AddPropertyField.price] = AppStrings.pleaseCompleteField(
        AppStrings.listingPrice,
      );
    }
    if (model.title.trim().length < 10) {
      errors[AddPropertyField.title] = AppStrings.titleMinLength;
    }
    return errors;
  }

  static Map<String, String> _typeDetails(AddPropertyModel model) {
    final type = model.propertyType;
    if (type == null) return const {};

    switch (type) {
      case PropertyApiEnums.typeApartment:
        return {
          ..._requireCount(model, DetailKeys.bedrooms, AppStrings.numberOfBedrooms),
          ..._requireCount(model, DetailKeys.bathrooms, AppStrings.numberOfBathrooms),
          ..._requirePresent(model, DetailKeys.floor, AppStrings.floorLabel),
          ..._requireString(model, DetailKeys.furnishing, AppStrings.furnitureCondition),
          ..._requireString(model, DetailKeys.condition, AppStrings.propertyCondition),
        };
      case PropertyApiEnums.typeVilla:
        return {
          ..._requireCount(model, DetailKeys.bedrooms, AppStrings.numberOfBedrooms),
          ..._requireCount(model, DetailKeys.bathrooms, AppStrings.numberOfBathrooms),
          ..._requireString(model, DetailKeys.furnishing, AppStrings.furnitureCondition),
          ..._requireString(model, DetailKeys.condition, AppStrings.propertyCondition),
        };
      case PropertyApiEnums.typeFloor:
        return {
          ..._requireCount(model, DetailKeys.bedrooms, AppStrings.numberOfBedrooms),
          ..._requireCount(model, DetailKeys.bathrooms, AppStrings.numberOfBathrooms),
          ..._requireString(model, DetailKeys.floorType, AppStrings.floorSlot),
          ..._requireString(model, DetailKeys.furnishing, AppStrings.furnitureCondition),
          ..._requireString(model, DetailKeys.condition, AppStrings.propertyCondition),
        };
      case PropertyApiEnums.typeTownhouse:
        return {
          ..._requireCount(model, DetailKeys.bedrooms, AppStrings.numberOfBedrooms),
          ..._requireCount(model, DetailKeys.bathrooms, AppStrings.numberOfBathrooms),
          ..._requirePresent(model, DetailKeys.floorsCount, AppStrings.numberOfFloors),
          ..._requireString(model, DetailKeys.furnishing, AppStrings.furnitureCondition),
          ..._requireString(model, DetailKeys.condition, AppStrings.propertyCondition),
        };
      case PropertyApiEnums.typeBuilding:
        return {
          ..._requirePresent(model, DetailKeys.floorsCount, AppStrings.totalFloorsInBuilding),
          ..._requirePresent(model, DetailKeys.totalApartments, AppStrings.totalApartments),
          ..._requireString(model, DetailKeys.classification, AppStrings.buildingClassification),
          ..._requireString(model, DetailKeys.condition, AppStrings.propertyCondition),
        };
      case PropertyApiEnums.typeLand:
        return {
          ..._requireString(model, DetailKeys.classification, AppStrings.landClassification),
        };
      case PropertyApiEnums.typeRestHouse:
        return {
          ..._requireCount(model, DetailKeys.bedrooms, AppStrings.numberOfBedrooms),
          ..._requireCount(model, DetailKeys.bathrooms, AppStrings.numberOfBathrooms),
        };
      case PropertyApiEnums.typeTower:
        return {
          ..._requireString(model, DetailKeys.name, AppStrings.towerName),
          ..._requirePresent(model, DetailKeys.floorsCount, AppStrings.totalFloorsInBuilding),
          ..._requireString(model, DetailKeys.classification, AppStrings.towerClassification),
          ..._requirePresent(model, DetailKeys.totalUnits, AppStrings.totalUnits),
          ..._requireString(model, DetailKeys.condition, AppStrings.propertyCondition),
        };
      case PropertyApiEnums.typeShop:
        return {
          ..._requirePresent(model, DetailKeys.frontWidth, AppStrings.frontagWidth),
          ..._requireString(model, DetailKeys.locationType, AppStrings.location),
        };
      case PropertyApiEnums.typeOffice:
        return {
          ..._requirePresent(model, DetailKeys.floor, AppStrings.floorLabel),
          ..._requireCount(model, DetailKeys.roomsCount, AppStrings.numberOfRooms),
        };
      case PropertyApiEnums.typeFarm:
        return {
          ..._requirePresent(model, DetailKeys.builtArea, AppStrings.builtArea),
          ..._requireString(model, DetailKeys.soilType, AppStrings.soilType),
        };
      case PropertyApiEnums.typeWarehouse:
        return {
          ..._requirePresent(model, DetailKeys.height, AppStrings.internalHeight),
          ..._requireString(model, DetailKeys.doorType, AppStrings.doorType),
          ..._requireString(model, DetailKeys.coolingType, AppStrings.cooling),
          ..._requireString(model, DetailKeys.floorType, AppStrings.flooring),
        };
      default:
        return const {};
    }
  }

  static Map<String, String> _requireCount(
    AddPropertyModel model,
    String key,
    String label,
  ) {
    final value = model.typeDetails[key];
    final count = value is int
        ? value
        : int.tryParse(value?.toString() ?? '') ?? 0;
    if (count <= 0) {
      return {key: AppStrings.pleaseCompleteField(label)};
    }
    return const {};
  }

  static Map<String, String> _requireString(
    AddPropertyModel model,
    String key,
    String label,
  ) {
    final value = model.typeDetails[key]?.toString().trim() ?? '';
    if (value.isEmpty) {
      return {key: AppStrings.pleaseCompleteField(label)};
    }
    return const {};
  }

  /// Accepts `0` (e.g. ground floor) as long as the user picked a value.
  static Map<String, String> _requirePresent(
    AddPropertyModel model,
    String key,
    String label,
  ) {
    final value = model.typeDetails[key];
    if (value == null) {
      return {key: AppStrings.pleaseCompleteField(label)};
    }
    if (value is String && value.trim().isEmpty) {
      return {key: AppStrings.pleaseCompleteField(label)};
    }
    return const {};
  }

  static bool _hasPositiveNumber(String? raw) {
    if (raw == null || raw.trim().isEmpty) return false;
    final buffer = StringBuffer();
    for (final char in raw.split('')) {
      final isDigit = char.compareTo('0') >= 0 && char.compareTo('9') <= 0;
      if (isDigit || char == '.') buffer.write(char);
    }
    final parsed = num.tryParse(buffer.toString());
    return parsed != null && parsed > 0;
  }
}
