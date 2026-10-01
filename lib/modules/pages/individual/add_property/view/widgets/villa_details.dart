import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_number_dropdown.dart';
import 'detail_counter.dart';
import 'detail_checkbox.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class VillaDetails extends StatelessWidget {
  const VillaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.villaDetails),
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
        DetailCounter(
          label: AppStrings.numberOfKitchensOptional,
          detailKey: DetailKeys.kitchens,
        ),
        DetailNumberDropdown(
          label: AppStrings.numberOfFloors,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.numberOptions(10, min: 1),
        ),
        SizedBox(height: 16.height),
        Row(
          children: [
            Expanded(
              child: DetailCheckbox(
                label: AppStrings.servantRoom,
                detailKey: DetailKeys.hasMaidRoom,
              ),
            ),
            Expanded(
              child: DetailCheckbox(
                label: AppStrings.driverRoom,
                detailKey: DetailKeys.hasDriverRoom,
              ),
            ),
          ],
        ),
        const FurnishingAndCondition(),
      ],
    );
  }
}
