import 'apartment_details_model.dart';
import 'building_details_model.dart';
import 'farm_details_model.dart';
import 'floor_details_model.dart';
import 'land_details_model.dart';
import 'office_details_model.dart';
import 'property_details_base.dart';
import 'property_enums.dart';
import 'rest_house_details_model.dart';
import 'shop_details_model.dart';
import 'tower_details_model.dart';
import 'townhouse_details_model.dart';
import 'villa_details_model.dart';
import 'warehouse_details_model.dart';

/// Rebuilds the correct [PropertyDetailsBase] subtype from a raw `details`
/// object, using the sibling `type` value to pick the shape.
///
/// Returns `null` for unknown types so callers can fall back instead of
/// crashing on a newly added backend type.
PropertyDetailsBase? propertyDetailsFromJson(
  String? propertyType,
  Map<String, dynamic>? details,
) {
  if (propertyType == null || details == null) return null;
  switch (propertyType) {
    case PropertyApiEnums.typeApartment:
      return ApartmentDetailsModel.fromJson(details);
    case PropertyApiEnums.typeVilla:
      return VillaDetailsModel.fromJson(details);
    case PropertyApiEnums.typeFloor:
      return FloorDetailsModel.fromJson(details);
    case PropertyApiEnums.typeTownhouse:
      return TownhouseDetailsModel.fromJson(details);
    case PropertyApiEnums.typeBuilding:
      return BuildingDetailsModel.fromJson(details);
    case PropertyApiEnums.typeLand:
      return LandDetailsModel.fromJson(details);
    case PropertyApiEnums.typeRestHouse:
      return RestHouseDetailsModel.fromJson(details);
    case PropertyApiEnums.typeTower:
      return TowerDetailsModel.fromJson(details);
    case PropertyApiEnums.typeShop:
      return ShopDetailsModel.fromJson(details);
    case PropertyApiEnums.typeOffice:
      return OfficeDetailsModel.fromJson(details);
    case PropertyApiEnums.typeFarm:
      return FarmDetailsModel.fromJson(details);
    case PropertyApiEnums.typeWarehouse:
      return WarehouseDetailsModel.fromJson(details);
    default:
      return null;
  }
}
