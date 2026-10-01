import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'detail_number_dropdown.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class BuildingDetails extends StatelessWidget {
  const BuildingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.buildingDetails),
        DetailNumberDropdown(
          label: AppStrings.totalFloorsInBuilding,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.floorsCountOptions,
        ),
        DetailNumberDropdown(
          label: AppStrings.totalApartments,
          detailKey: DetailKeys.totalApartments,
          options: AddPropertyBloc.unitCountOptions,
        ),
        SizedBox(height: 16.height),
        LabeledCounterPair(
          firstLabel: AppStrings.numberOfShopsOptional,
          firstKey: DetailKeys.shopsCount,
          secondLabel: AppStrings.numberOfParkingSpaces,
          secondKey: DetailKeys.parkingSpots,
        ),
        DetailDropdown(
          label: AppStrings.buildingClassification,
          detailKey: DetailKeys.classification,
          options: AddPropertyBloc.classificationOptions,
        ),
        const FurnishingAndCondition(includeFurnishing: false),
      ],
    );
  }
}
