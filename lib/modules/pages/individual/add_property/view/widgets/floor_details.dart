import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_dropdown.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class FloorDetails extends StatelessWidget {
  const FloorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.floorDetails),
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
        DetailDropdown(
          label: AppStrings.floorSlot,
          detailKey: DetailKeys.floorType,
          options: AddPropertyBloc.floorTypeOptions,
        ),
        const FurnishingAndCondition(),
      ],
    );
  }
}
