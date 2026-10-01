import 'package:flutter/material.dart';
import '../../../../../../core/utils/constants/app_strings.dart';
import '../../../../../../core/utils/functions/responsive.dart';
import '../../controller/add_property_bloc.dart';
import '../../model/add_property_request_mapper.dart';
import 'property_inputs/property_details_section_header.dart';
import 'detail_number_dropdown.dart';
import 'detail_text_field.dart';
import 'detail_multi_chips.dart';
import 'detail_bool_radio.dart';
import 'labeled_counter_pair.dart';
import 'furnishing_and_condition.dart';

class TownhouseDetails extends StatelessWidget {
  const TownhouseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PropertyDetailsSectionHeaderWidget(title: AppStrings.townhouseDetails),
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
        DetailNumberDropdown(
          label: AppStrings.numberOfFloors,
          detailKey: DetailKeys.floorsCount,
          options: AddPropertyBloc.numberOptions(10, min: 1),
        ),
        DetailTextField(
          label: AppStrings.complexName,
          detailKey: DetailKeys.compoundName,
        ),
        DetailMultiChips(
          label: AppStrings.communityFacilities,
          detailKey: DetailKeys.communityFacilities,
          options: AddPropertyBloc.communityFacilityOptions,
        ),
        SizedBox(height: 8.height),
        DetailBoolRadio(
          label: AppStrings.clubhouse,
          detailKey: DetailKeys.hasClubhouse,
        ),
        DetailNumberDropdown(
          label: AppStrings.numberOfParkingSpaces,
          detailKey: DetailKeys.parkingSpots,
          options: AddPropertyBloc.numberOptions(10),
        ),
        DetailTextField(
          label: AppStrings.communityServiceFeesOptional,
          detailKey: DetailKeys.serviceFee,
          isNumeric: true,
        ),
        const FurnishingAndCondition(),
      ],
    );
  }
}
