import 'add_property_model.dart';
import 'apartment_details_model.dart';
import 'building_details_model.dart';
import 'create_property_request_model.dart';
import 'farm_details_model.dart';
import 'floor_details_model.dart';
import 'land_details_model.dart';
import 'land_dimensions_model.dart';
import 'office_details_model.dart';
import 'property_deed_model.dart';
import 'property_details_base.dart';
import 'property_enums.dart';
import 'property_location_model.dart';
import 'rest_house_details_model.dart';
import 'shop_details_model.dart';
import 'tower_details_model.dart';
import 'townhouse_details_model.dart';
import 'villa_details_model.dart';
import 'warehouse_details_model.dart';

/// API field names used by the per-type `details` payloads.
///
/// The widgets write into [AddPropertyModel.typeDetails] under these keys and
/// the mapper reads them back, so both sides share one vocabulary.
class DetailKeys {
  DetailKeys._();

  static const String bedrooms = 'bedrooms';
  static const String bathrooms = 'bathrooms';
  static const String councils = 'councils';
  static const String livingRooms = 'livingRooms';
  static const String kitchens = 'kitchens';
  static const String floor = 'floor';
  static const String floorType = 'floorType';
  static const String floorsCount = 'floorsCount';
  static const String totalFloors = 'totalFloors';
  static const String apartmentsPerFloor = 'apartmentsPerFloor';
  static const String apartmentNumber = 'apartmentNumber';
  static const String furnishing = 'furnishing';
  static const String condition = 'condition';
  static const String developerName = 'developerName';
  static const String hasMaidRoom = 'hasMaidRoom';
  static const String hasDriverRoom = 'hasDriverRoom';
  static const String compoundName = 'compoundName';
  static const String hasClubhouse = 'hasClubhouse';
  static const String serviceFee = 'serviceFee';
  static const String parkingSpots = 'parkingSpots';
  static const String communityFacilities = 'communityFacilities';
  static const String totalApartments = 'totalApartments';
  static const String shopsCount = 'shopsCount';
  static const String classification = 'classification';
  static const String plotNumber = 'plotNumber';
  static const String planNumber = 'planNumber';
  static const String dimensionNorth = 'dimensionNorth';
  static const String dimensionSouth = 'dimensionSouth';
  static const String dimensionEast = 'dimensionEast';
  static const String dimensionWest = 'dimensionWest';
  static const String buildingRatio = 'buildingRatio';
  static const String allowedFloors = 'allowedFloors';
  static const String services = 'services';
  static const String hasGarden = 'hasGarden';
  static const String hasPool = 'hasPool';
  static const String name = 'name';
  static const String totalUnits = 'totalUnits';
  static const String elevatorsCount = 'elevatorsCount';
  static const String parkingFloors = 'parkingFloors';
  static const String totalParking = 'totalParking';
  static const String amenities = 'amenities';
  static const String views = 'views';
  static const String yearBuilt = 'yearBuilt';
  static const String roomsCount = 'roomsCount';
  static const String facilities = 'facilities';
  static const String furnishedOffice = 'furnishedOffice';
  static const String frontWidth = 'frontWidth';
  static const String locationType = 'locationType';
  static const String mallName = 'mallName';
  static const String activities = 'activities';
  static const String builtArea = 'builtArea';
  static const String soilType = 'soilType';
  static const String waterSources = 'waterSources';
  static const String wellsCount = 'wellsCount';
  static const String wellDepth = 'wellDepth';
  static const String palmTreesCount = 'palmTreesCount';
  static const String distanceToCity = 'distanceToCity';
  static const String height = 'height';
  static const String doorsCount = 'doorsCount';
  static const String doorType = 'doorType';
  static const String coolingType = 'coolingType';
  static const String hasOffice = 'hasOffice';
  static const String electricityKW = 'electricityKW';
  static const String hasYard = 'hasYard';
  static const String yardArea = 'yardArea';
}

/// Translates the wizard's form state into the `POST /properties` request.
extension AddPropertyRequestMapper on AddPropertyModel {
  /// JSON body for `POST /evaluations/preview`.
  Map<String, dynamic> toEvaluationPreviewBody() {
    final type = propertyType ?? '';
    final details = type.isEmpty ? null : _buildDetails(type);
    final totalArea = _digitsOnly(area);
    return {
      'title': title,
      'type': type,
      'listingType': PropertyApiEnums.listingTypeFromOperation(operationType),
      'totalArea': totalArea.isEmpty ? '0' : totalArea,
      'details': details?.toJson() ?? <String, dynamic>{},
      'features': amenities.toList(),
    };
  }

  /// Returns `null` when the form is missing data the endpoint requires
  /// (property type or map coordinates).
  CreatePropertyRequestModel? toCreateRequest({String? brokerId}) {
    final type = propertyType;
    if (type == null || type.isEmpty) return null;
    if (latitude == null || longitude == null) return null;

    return CreatePropertyRequestModel(
      title: title,
      type: type,
      listingType: PropertyApiEnums.listingTypeFromOperation(operationType),
      price: _num(price) ?? 0,
      totalArea: _num(area) ?? 0,
      location: PropertyLocationModel(
        city: city.isNotEmpty
            ? city
            : (location?.split('\n').first.trim() ?? ''),
        district: district.isNotEmpty ? district : (location ?? ''),
        latitude: latitude!,
        longitude: longitude!,
        street: street,
        buildingNumber: buildingNumber,
      ),
      details: _buildDetails(type),
      paymentType: hasRentInstallment
          ? PropertyApiEnums.paymentInstallment
          : PropertyApiEnums.paymentCash,
      brokerId: brokerId,
      features: amenities.toList(),
      deeds: _buildDeeds(),
      imagePaths: imagePaths,
      virtualTourPath:
          (virtualTourPath != null && virtualTourPath!.isNotEmpty)
          ? virtualTourPath
          : null,
      videoPath: (videoPath != null && videoPath!.isNotEmpty) ? videoPath : null,
      description: description,
      rentPeriod: PropertyApiEnums.rentPeriodFromUi(rentalPeriod),
      projectName: developerName.isNotEmpty ? developerName : null,
      propertyAge: propertyAge,
      facadeDirection: facade,
      streetsCount: streetCount,
      streetWidth: _num(streetWidth),
    );
  }

  List<PropertyDeedModel> _buildDeeds() {
    if (deedType == null || deedType!.isEmpty) return const [];
    return [
      PropertyDeedModel(
        deedType: PropertyApiEnums.deedTypeFromUi(deedType),
        deedNumber: deedNumber.isNotEmpty ? deedNumber : null,
        calendarType: PropertyApiEnums.calendarTypeFromUi(dateType),
        deedDate: date.isNotEmpty ? date : null,
        ownershipDocumentPath: ownershipDocumentPath,
      ),
    ];
  }

  PropertyDetailsBase? _buildDetails(String type) {
    switch (type) {
      case PropertyApiEnums.typeApartment:
        return ApartmentDetailsModel(
          bedrooms: _detailInt(DetailKeys.bedrooms),
          bathrooms: _detailInt(DetailKeys.bathrooms),
          councils: _detailInt(DetailKeys.councils),
          livingRooms: _detailInt(DetailKeys.livingRooms),
          floor: _detailInt(DetailKeys.floor),
          totalFloors: _detailInt(DetailKeys.totalFloors),
          apartmentsPerFloor: _detailInt(DetailKeys.apartmentsPerFloor),
          apartmentNumber: _detailString(DetailKeys.apartmentNumber),
          furnishing: _detailString(DetailKeys.furnishing),
          condition: _detailString(DetailKeys.condition),
        );

      case PropertyApiEnums.typeVilla:
        return VillaDetailsModel(
          floorsCount: _detailInt(DetailKeys.floorsCount),
          bedrooms: _detailInt(DetailKeys.bedrooms),
          bathrooms: _detailInt(DetailKeys.bathrooms),
          councils: _detailInt(DetailKeys.councils),
          livingRooms: _detailInt(DetailKeys.livingRooms),
          kitchens: _detailInt(DetailKeys.kitchens),
          hasMaidRoom: _detailBool(DetailKeys.hasMaidRoom),
          hasDriverRoom: _detailBool(DetailKeys.hasDriverRoom),
          furnishing: _detailString(DetailKeys.furnishing),
          condition: _detailString(DetailKeys.condition),
          developerName: _detailString(DetailKeys.developerName),
        );

      case PropertyApiEnums.typeFloor:
        return FloorDetailsModel(
          floorType: _detailString(DetailKeys.floorType),
          bedrooms: _detailInt(DetailKeys.bedrooms),
          bathrooms: _detailInt(DetailKeys.bathrooms),
          councils: _detailInt(DetailKeys.councils),
          livingRooms: _detailInt(DetailKeys.livingRooms),
          furnishing: _detailString(DetailKeys.furnishing),
          condition: _detailString(DetailKeys.condition),
        );

      case PropertyApiEnums.typeTownhouse:
        return TownhouseDetailsModel(
          floorsCount: _detailInt(DetailKeys.floorsCount),
          bedrooms: _detailInt(DetailKeys.bedrooms),
          bathrooms: _detailInt(DetailKeys.bathrooms),
          councils: _detailInt(DetailKeys.councils),
          livingRooms: _detailInt(DetailKeys.livingRooms),
          compoundName: _detailString(DetailKeys.compoundName),
          hasClubhouse: _detailBool(DetailKeys.hasClubhouse),
          serviceFee: _detailNum(DetailKeys.serviceFee),
          parkingSpots: _detailInt(DetailKeys.parkingSpots),
          communityFacilities: detailList(DetailKeys.communityFacilities),
          furnishing: _detailString(DetailKeys.furnishing),
          condition: _detailString(DetailKeys.condition),
          developerName: _detailString(DetailKeys.developerName),
        );

      case PropertyApiEnums.typeBuilding:
        return BuildingDetailsModel(
          floorsCount: _detailInt(DetailKeys.floorsCount),
          totalApartments: _detailInt(DetailKeys.totalApartments),
          shopsCount: _detailInt(DetailKeys.shopsCount),
          classification: _detailString(DetailKeys.classification),
          parkingSpots: _detailInt(DetailKeys.parkingSpots),
          condition: _detailString(DetailKeys.condition),
          developerName: _detailString(DetailKeys.developerName),
        );

      case PropertyApiEnums.typeLand:
        return LandDetailsModel(
          classification: _detailString(DetailKeys.classification),
          plotNumber: _detailString(DetailKeys.plotNumber),
          planNumber: _detailString(DetailKeys.planNumber),
          dimensions: _buildDimensions(),
          buildingRatio: _detailNum(DetailKeys.buildingRatio),
          allowedFloors: _detailInt(DetailKeys.allowedFloors),
          services: detailList(DetailKeys.services),
        );

      case PropertyApiEnums.typeRestHouse:
        return RestHouseDetailsModel(
          bedrooms: _detailInt(DetailKeys.bedrooms),
          bathrooms: _detailInt(DetailKeys.bathrooms),
          councils: _detailInt(DetailKeys.councils),
          livingRooms: _detailInt(DetailKeys.livingRooms),
          hasGarden: _detailBool(DetailKeys.hasGarden),
          hasPool: _detailBool(DetailKeys.hasPool),
          condition: _detailString(DetailKeys.condition),
        );

      case PropertyApiEnums.typeTower:
        return TowerDetailsModel(
          name: _detailString(DetailKeys.name),
          floorsCount: _detailInt(DetailKeys.floorsCount),
          classification: _detailString(DetailKeys.classification),
          totalUnits: _detailInt(DetailKeys.totalUnits),
          elevatorsCount: _detailInt(DetailKeys.elevatorsCount),
          parkingFloors: _detailInt(DetailKeys.parkingFloors),
          totalParking: _detailInt(DetailKeys.totalParking),
          amenities: detailList(DetailKeys.amenities),
          views: detailList(DetailKeys.views),
          yearBuilt: _detailInt(DetailKeys.yearBuilt),
          condition: _detailString(DetailKeys.condition),
          developerName: _detailString(DetailKeys.developerName),
        );

      case PropertyApiEnums.typeShop:
        return ShopDetailsModel(
          frontWidth: _detailNum(DetailKeys.frontWidth),
          locationType: _detailString(DetailKeys.locationType),
          mallName: _detailString(DetailKeys.mallName),
          facilities: detailList(DetailKeys.facilities),
          activities: detailList(DetailKeys.activities),
          condition: _detailString(DetailKeys.condition),
        );

      case PropertyApiEnums.typeOffice:
        return OfficeDetailsModel(
          floor: _detailInt(DetailKeys.floor),
          roomsCount: _detailInt(DetailKeys.roomsCount),
          bathrooms: _detailInt(DetailKeys.bathrooms),
          facilities: detailList(DetailKeys.facilities),
          furnishedOffice: _detailBool(DetailKeys.furnishedOffice),
          furnishing: _detailString(DetailKeys.furnishing),
          condition: _detailString(DetailKeys.condition),
        );

      case PropertyApiEnums.typeFarm:
        return FarmDetailsModel(
          builtArea: _detailNum(DetailKeys.builtArea),
          soilType: _detailString(DetailKeys.soilType),
          waterSources: detailList(DetailKeys.waterSources),
          wellsCount: _detailInt(DetailKeys.wellsCount),
          wellDepth: _detailNum(DetailKeys.wellDepth),
          palmTreesCount: _detailInt(DetailKeys.palmTreesCount),
          facilities: detailList(DetailKeys.facilities),
          distanceToCity: _detailNum(DetailKeys.distanceToCity),
          condition: _detailString(DetailKeys.condition),
        );

      case PropertyApiEnums.typeWarehouse:
        return WarehouseDetailsModel(
          height: _detailNum(DetailKeys.height),
          doorsCount: _detailInt(DetailKeys.doorsCount),
          doorType: _detailString(DetailKeys.doorType),
          coolingType: _detailString(DetailKeys.coolingType),
          hasOffice: _detailBool(DetailKeys.hasOffice),
          electricityKW: _detailNum(DetailKeys.electricityKW),
          floorType: _detailString(DetailKeys.floorType),
          hasYard: _detailBool(DetailKeys.hasYard),
          yardArea: _detailNum(DetailKeys.yardArea),
          condition: _detailString(DetailKeys.condition),
        );

      default:
        return null;
    }
  }

  LandDimensionsModel? _buildDimensions() {
    final dimensions = LandDimensionsModel(
      north: _detailNum(DetailKeys.dimensionNorth),
      south: _detailNum(DetailKeys.dimensionSouth),
      east: _detailNum(DetailKeys.dimensionEast),
      west: _detailNum(DetailKeys.dimensionWest),
    );
    return dimensions.isEmpty ? null : dimensions;
  }

  // ── typeDetails readers ──────────────────────────────────────────────────
  // Values arrive either already typed (counters, toggles, chips) or as text
  // from a controller, so each reader accepts both.

  String? _detailString(String key) {
    final value = typeDetails[key];
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  int? _detailInt(String key) {
    final value = typeDetails[key];
    if (value is int) return value > 0 ? value : null;
    if (value is num) return value.toInt();
    final text = _detailString(key);
    return text == null ? null : int.tryParse(_digitsOnly(text));
  }

  num? _detailNum(String key) {
    final value = typeDetails[key];
    if (value is num) return value;
    final text = _detailString(key);
    return text == null ? null : num.tryParse(_digitsOnly(text));
  }

  bool? _detailBool(String key) {
    final value = typeDetails[key];
    if (value is bool) return value;
    if (value == null) return null;
    return value.toString() == PropertyApiEnums.availabilityExist;
  }

  num? _num(String? value) {
    if (value == null || value.isEmpty) return null;
    return num.tryParse(_digitsOnly(value));
  }

  /// Strips grouping separators and unit suffixes the fields may contain.
  String _digitsOnly(String value) {
    final buffer = StringBuffer();
    for (final char in value.split('')) {
      final isDigit = char.compareTo('0') >= 0 && char.compareTo('9') <= 0;
      if (isDigit || char == '.' || char == '-') buffer.write(char);
    }
    return buffer.toString();
  }
}
