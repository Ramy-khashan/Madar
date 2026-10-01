import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_number_dropdown.dart';
import 'detail_text_field.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class ApartmentDetails extends StatelessWidget {
  const ApartmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.apartmentDetails),
        SizedBox(height: 16.height),
        LabeledCounterPair(
          firstLabel: AppStrings.numberOfBedrooms,
          firstKey: DetailKeys.bedrooms,
          secondLabel: AppStrings.numberOfBathrooms,
          secondKey: DetailKeys.bathrooms,
        ),
        SizedBox(height: 12.height),
        LabeledCounterPair(
          firstLabel: AppStrings.numberOfLivingRoomsOptional,
          firstKey: DetailKeys.livingRooms,
          secondLabel: AppStrings.numberOfLoungesOptional,
          secondKey: DetailKeys.councils,
        ),
        SizedBox(height: 12.height),
        DetailTextField(
          label: AppStrings.apartmentNumberOptional,
          detailKey: DetailKeys.apartmentNumber,
        ),
        DetailNumberDropdown(
          label: AppStrings.totalFloorsInBuilding,
          detailKey: DetailKeys.totalFloors,
          options: AddPropertyBloc.floorsCountOptions,
        ),
        DetailNumberDropdown(
          label: AppStrings.numberOfApartmentsPerFloorOptional,
          detailKey: DetailKeys.apartmentsPerFloor,
          options: AddPropertyBloc.numberOptions(20, min: 1),
        ),
        DetailNumberDropdown(
          label: AppStrings.floorLabel,
          detailKey: DetailKeys.floor,
          options: AddPropertyBloc.floorNumberOptions,
        ),
        const FurnishingAndCondition(),
      ],
    );
  }
}
