import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/add_property_bloc.dart';
import '../../model/property_enums.dart';
import 'apartment_details.dart';
import 'villa_details.dart';
import 'floor_details.dart';
import 'townhouse_details.dart';
import 'building_details.dart';
import 'land_details.dart';
import 'rest_house_details.dart';
import 'tower_details.dart';
import 'shop_details.dart';
import 'office_details.dart';
import 'farm_details.dart';
import 'warehouse_details.dart';

class PropertyDetailsTypeWidget extends StatelessWidget {
  const PropertyDetailsTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPropertyBloc, AddPropertyState>(
      buildWhen: (prev, curr) =>
          prev.model.propertyType != curr.model.propertyType,
      builder: (context, state) {
        return _buildPropertyTypeDetails(state.model.propertyType);
      },
    );
  }

  Widget _buildPropertyTypeDetails(String? propertyType) {
    switch (propertyType) {
      case PropertyApiEnums.typeApartment:
        return const ApartmentDetails();
      case PropertyApiEnums.typeVilla:
        return const VillaDetails();
      case PropertyApiEnums.typeFloor:
        return const FloorDetails();
      case PropertyApiEnums.typeTownhouse:
        return const TownhouseDetails();
      case PropertyApiEnums.typeBuilding:
        return const BuildingDetails();
      case PropertyApiEnums.typeLand:
        return const LandDetails();
      case PropertyApiEnums.typeRestHouse:
        return const RestHouseDetails();
      case PropertyApiEnums.typeTower:
        return const TowerDetails();
      case PropertyApiEnums.typeShop:
        return const ShopDetails();
      case PropertyApiEnums.typeOffice:
        return const OfficeDetails();
      case PropertyApiEnums.typeFarm:
        return const FarmDetails();
      case PropertyApiEnums.typeWarehouse:
        return const WarehouseDetails();
      default:
        return const SizedBox.shrink();
    }
  }
}
