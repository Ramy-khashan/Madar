import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'detail_number_dropdown.dart';
import 'detail_text_field.dart';
import 'detail_multi_chips.dart';
import 'furnishing_and_condition.dart';

class TowerDetails extends StatelessWidget {
  const TowerDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.towerDetails),
        DetailTextField(
          label: AppStrings.towerName,
          detailKey: DetailKeys.name,
        ),
        DetailNumberDropdown(
          label: AppStrings.totalFloorsInBuilding,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.floorsCountOptions,
        ),
        DetailDropdown(
          label: AppStrings.towerClassification,
          detailKey: DetailKeys.classification,
          options: AddPropertyBloc.towerClassificationOptions,
        ),
        DetailTextField(
          label: AppStrings.totalUnits,
          detailKey: DetailKeys.totalUnits,
          isNumeric: true,
        ),
        DetailTextField(
          label: AppStrings.numberOfElevators,
          detailKey: DetailKeys.elevatorsCount,
          isNumeric: true,
        ),
        DetailNumberDropdown(
          label: AppStrings.parkingFloors,
          detailKey: DetailKeys.parkingFloors,
          options: AddPropertyBloc.parkingFloorOptions,
        ),
        DetailTextField(
          label: AppStrings.totalParkingSpaces,
          detailKey: DetailKeys.totalParking,
          isNumeric: true,
        ),
        DetailMultiChips(
          label: AppStrings.facilities,
          detailKey: DetailKeys.amenities,
          options: AddPropertyBloc.towerAmenityOptions,
        ),
        DetailMultiChips(
          label: AppStrings.view,
          detailKey: DetailKeys.views,
          options: AddPropertyBloc.viewOptions,
        ),
        DetailTextField(
          label: AppStrings.yearBuilt,
          detailKey: DetailKeys.yearBuilt,
          isNumeric: true,
        ),
        const FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}
